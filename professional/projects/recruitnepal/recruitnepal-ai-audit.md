# RecruitNepal AI Repository - Comprehensive Engineering Audit
**Audit Date:** February 14, 2026  
**Auditor:** Principal Engineer (Aibo)  
**Repository:** `recruitnepal-ai` (Python/FastAPI)

---

## Executive Summary

The RecruitNepal AI repository is a **solid foundation** for a CV extraction and matching platform. It demonstrates good architectural decisions (FastAPI, microservices-ready with Celery), proper use of async/await patterns, and structured data validation with Pydantic. However, there are **critical gaps** in production readiness, observability, error handling, and scalability patterns that need addressing.

**Overall Assessment:** 6.5/10 production-ready  
**Key Strengths:** Clean architecture, good separation of concerns, async-first design  
**Key Weaknesses:** Error handling, testing, logging, configuration management, security hardening

---

## 🏗️ Architecture Analysis

### Strengths
1. **Clean layered architecture** - Good separation between routers, services, models
2. **Async-first design** - Proper use of FastAPI + async/await
3. **Task queue ready** - Celery integration for async CV extraction (background jobs)
4. **Multiple AI providers** - Support for both Azure OpenAI and Google Gemini (good for fallback/flexibility)
5. **Structured data models** - Comprehensive Pydantic models for CV extraction

### Issues & Recommendations

#### 1. **CORS Configuration - CRITICAL SECURITY ISSUE** ⚠️
**File:** `app/main.py`
```python
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # ❌ DANGEROUS IN PRODUCTION
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```
**Problem:**
- `allow_origins=["*"]` with `allow_credentials=True` is a **security vulnerability**
- Opens the API to cross-origin requests from ANY domain
- Violates OWASP security guidelines

**Fix:**
```python
ALLOWED_ORIGINS = os.getenv(
    "ALLOWED_ORIGINS",
    "http://localhost:3000,http://localhost:8000"
).split(",")

app.add_middleware(
    CORSMiddleware,
    allow_origins=ALLOWED_ORIGINS,
    allow_credentials=True,
    allow_methods=["GET", "POST"],  # Be explicit
    allow_headers=["Content-Type", "Authorization"],  # Be explicit
    max_age=3600,
)
```

**Action:** Implement environment-based CORS configuration immediately.

---

#### 2. **Error Handling - Inconsistent & Incomplete**
**Files:** `app/routers/cv_router.py`, `app/services/`

**Problems:**
- Mixed error handling patterns (JSONResponse vs exceptions)
- Swallowing exceptions silently in several places
- No structured error responses
- No request ID tracing for debugging

**Example of inconsistent handling:**
```python
# In cv_router.py - Sometimes returns JSONResponse with 400
# Sometimes raises HTTPException (which FastAPI converts differently)
# Sometimes returns plain dicts

try:
    payload = result.get(timeout=0)
except Exception:
    pass  # ❌ Silent failure - no logging, no user feedback
```

**Recommended Error Handling Pattern:**
```python
from enum import Enum
from typing import Optional

class ErrorCode(str, Enum):
    FILE_INVALID = "FILE_INVALID"
    FILE_TOO_LARGE = "FILE_TOO_LARGE"
    UNSUPPORTED_FORMAT = "UNSUPPORTED_FORMAT"
    AI_PROCESSING_FAILED = "AI_PROCESSING_FAILED"
    INTERNAL_ERROR = "INTERNAL_ERROR"

class ErrorResponse(BaseModel):
    code: ErrorCode
    message: str
    request_id: str
    details: Optional[dict] = None

# Consistent error handler
@app.exception_handler(CVExtractionException)
async def cv_extraction_exception_handler(request, exc):
    request_id = request.headers.get("X-Request-ID", str(uuid.uuid4()))
    logger.error(f"CV extraction error [{request_id}]: {exc}")
    return JSONResponse(
        status_code=exc.status_code,
        content=ErrorResponse(
            code=exc.error_code,
            message=exc.message,
            request_id=request_id,
        ).model_dump()
    )
```

**Action:** Implement structured error handling with request IDs for full request tracing.

---

#### 3. **Configuration Management - Hard to Extend**
**File:** `app/core/config.py`

**Issues:**
- All settings in single Settings class (hard to organize at scale)
- No environment-specific config (dev/staging/prod)
- No validation of config at startup
- Multiple deployment names suggest confusion about which model to use

**Recommended Structure:**
```
app/core/
├── config/
│   ├── base.py          # Shared settings
│   ├── development.py   # Dev-specific
│   ├── staging.py       # Staging-specific
│   └── production.py    # Prod-specific
└── config_loader.py     # Load based on ENV
```

**Action:** Reorganize config for multi-environment support.

---

## 🔍 Code Quality Issues

### 1. **Missing Input Validation**
**File:** `app/routers/cv_matching_router.py`
```python
# ❌ No validation of callback_url format, webhook secret verification
# ❌ No rate limiting on extraction endpoint
# ❌ No request size limits
```

**Add:**
```python
from pydantic import HttpUrl, validator

class CVExtractionRequest(BaseModel):
    callback_url: HttpUrl
    timeout_minutes: int = Field(ge=1, le=60)
    
    @validator('callback_url')
    def validate_callback_secure(cls, v):
        if v.scheme not in ['https']:
            raise ValueError("Callback URL must use HTTPS in production")
        return v
```

### 2. **Async/Await Anti-patterns**
**File:** `app/services/cvExtraction/cv_extraction.py`
```python
# Using async methods but not awaiting them consistently
# Mixing blocking I/O with async code
```

**Problem:** FileParserService likely has blocking I/O that should be wrapped:
```python
# ❌ Current (blocks event loop)
cv_text = file_parser.parse_file(file, ext)

# ✅ Better
cv_text = await asyncio.to_thread(file_parser.parse_file, file, ext)
```

### 3. **No Tests**
**File:** None (no `tests/` directory found)

**Action:** Create comprehensive test suite:
```
tests/
├── unit/
│   ├── services/
│   └── models/
├── integration/
│   └── routers/
└── e2e/
    └── cv_extraction_flow.py
```

---

## 📊 Logging & Observability

### Issues

1. **Basic logging only**
   - No structured logging (JSON format)
   - No log levels properly configured
   - No correlation IDs for tracing requests

2. **No metrics/monitoring**
   - No Prometheus/OpenTelemetry integration
   - Can't track:
     - API latency
     - Extraction success rates
     - AI API costs
     - Celery task processing time

3. **No tracing**
   - Requests disappear into background jobs with no way to track status
   - Webhook callbacks with no failure tracking

**Recommended Setup:**
```python
# Use OpenTelemetry + Prometheus
from opentelemetry import trace, metrics
from opentelemetry.exporter.prometheus import PrometheusMetricReader
from opentelemetry.sdk.trace.export import BatchSpanProcessor

# Track extraction latency
extraction_latency = metrics.Histogram(
    name="cv_extraction_latency_ms",
    unit="ms",
    description="CV extraction processing time"
)

# Track AI API costs
ai_api_costs = metrics.Counter(
    name="ai_api_costs_dollars",
    unit="1",
    description="Total API costs"
)
```

---

## 🔐 Security Concerns

### 1. **API Key Authentication - Weak**
**File:** `app/core/api_key_auth.py`
```python
# Likely just checking header presence without rate limiting
# No key rotation mechanism
# No audit logging of API key usage
```

**Recommendations:**
- Implement API key versioning
- Add rate limiting per key
- Log all API key usage
- Add IP whitelisting option
- Implement key expiration

### 2. **File Upload Vulnerabilities**
**File:** `app/routers/cv_router.py`
```python
# Stores uploaded files in `uploads/` directory with predictable names
safe_name = f"{unique_id}_{os.path.basename(file.filename or 'document')}"
```

**Risks:**
- Path traversal attacks possible if `file.filename` isn't sanitized
- Uploaded files aren't scanned for malware
- No file size streaming (loads entire file in memory)
- No quarantine for suspicious files

**Fix:**
```python
import secrets
from pathlib import Path

def generate_safe_filename(original_filename: str) -> str:
    """Generate cryptographically safe filename."""
    ext = Path(original_filename).suffix
    random_name = secrets.token_urlsafe(16)
    return f"{random_name}{ext}"

# Use streaming upload for large files
async def stream_upload_file(file: UploadFile, max_size: int):
    chunk_size = 1024 * 1024  # 1MB chunks
    total_size = 0
    chunks = []
    
    async for chunk in file.file:
        total_size += len(chunk)
        if total_size > max_size:
            raise FileSizeError(f"File exceeds {max_size} bytes")
        chunks.append(chunk)
    
    return b"".join(chunks)
```

### 3. **Webhook Callback Security - Missing Implementation**
**File:** `app/routers/cv_router.py`
```python
# webhook_secret is defined in config but NOT USED
# No signature verification for callbacks
```

**Add webhook signature verification:**
```python
def verify_webhook_signature(payload: str, signature: str) -> bool:
    """Verify webhook callback signature using HMAC-SHA256."""
    expected = hmac.new(
        settings.webhook_secret.encode(),
        payload.encode(),
        hashlib.sha256
    ).hexdigest()
    return hmac.compare_digest(signature, expected)
```

---

## 📈 Performance & Scalability

### 1. **Vector Database - Qdrant Not Well Integrated**
**File:** `app/services/vectorstore/qdrant_client.py` (exists but not used in extraction)

- Vector storage is initialized but appears unused in main extraction flow
- No caching of embeddings
- No batch operations for bulk processing

### 2. **Celery Configuration - Missing**
**File:** `app/core/celery_app.py`

Missing:
- Result backend configuration
- Task routing rules
- Retry policies  
- Dead letter queue handling
- Task time limits

**Recommended Celery Config:**
```python
from celery import Celery
from kombu import Exchange, Queue

app = Celery('recruitnepal')

app.conf.update(
    broker_url=settings.redis_url,
    result_backend=settings.redis_url,
    task_serializer='json',
    accept_content=['json'],
    result_serializer='json',
    timezone='UTC',
    enable_utc=True,
    
    # Task routing
    task_routes={
        'process_cv_extraction': {'queue': 'cv_extraction'},
        'process_cv_matching': {'queue': 'cv_matching'},
    },
    
    # Retry policy
    task_acks_late=True,
    worker_prefetch_multiplier=1,
    
    # Time limits
    task_time_limit=30 * 60,  # 30 minutes
    task_soft_time_limit=25 * 60,  # 25 minutes
    
    # Dead letter queue
    task_reject_on_worker_lost=True,
)
```

### 3. **No Connection Pooling**
- Azure OpenAI client created once (good)
- Redis client not managed centrally
- Qdrant client connections not pooled
- File I/O not optimized

---

## 🚀 Recommendations - Quick Wins (1-2 weeks)

1. **🔴 CRITICAL:** Fix CORS configuration
2. **🔴 CRITICAL:** Implement structured error handling with request IDs
3. **🟠 HIGH:** Add comprehensive logging with structured JSON format
4. **🟠 HIGH:** Implement webhook signature verification
5. **🟠 HIGH:** Add file upload sanitization
6. **🟡 MEDIUM:** Add basic test suite (unit tests)
7. **🟡 MEDIUM:** Document all API endpoints
8. **🟢 LOW:** Add rate limiting middleware

---

## 🏗️ Recommended Improvements - Longer Term (1-3 months)

### Phase 1: Production Hardening (Weeks 1-3)
- [ ] Fix all security issues (CORS, file upload, webhooks)
- [ ] Implement structured error handling
- [ ] Add comprehensive logging/tracing
- [ ] Document deployment procedure
- [ ] Create health checks for all dependencies

### Phase 2: Testing & Quality (Weeks 2-4)
- [ ] Write unit tests (target 70% coverage)
- [ ] Integration tests for CV extraction pipeline
- [ ] Load tests for API endpoints
- [ ] E2E tests for complete workflows

### Phase 3: Observability (Weeks 3-5)
- [ ] Implement OpenTelemetry instrumentation
- [ ] Add Prometheus metrics
- [ ] Set up distributed tracing
- [ ] Create dashboards for operational metrics

### Phase 4: Scalability (Weeks 4-8)
- [ ] Optimize Celery configuration
- [ ] Implement result caching
- [ ] Add horizontal scaling documentation
- [ ] Optimize vector database queries
- [ ] Profile and optimize hot paths

### Phase 5: Advanced Features (Weeks 6+)
- [ ] Implement batch CV processing
- [ ] Add webhook retry mechanism with exponential backoff
- [ ] Multi-tenant support
- [ ] API versioning strategy
- [ ] Usage analytics & billing

---

## 📋 Specific Code Improvements

### 1. Add Request Middleware for Tracing
```python
# app/middleware/request_context.py
import uuid
from contextvars import ContextVar
from starlette.middleware.base import BaseHTTPMiddleware
from starlette.requests import Request

request_id_var: ContextVar[str] = ContextVar('request_id')

class RequestContextMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request: Request, call_next):
        request_id = request.headers.get('X-Request-ID', str(uuid.uuid4()))
        request_id_var.set(request_id)
        
        response = await call_next(request)
        response.headers['X-Request-ID'] = request_id
        return response

# In main.py
app.add_middleware(RequestContextMiddleware)
```

### 2. Add Health Check Endpoint
```python
# app/routers/health_router.py
@router.get("/health", tags=["Health"])
async def health_check():
    checks = {
        "status": "healthy",
        "services": {}
    }
    
    # Check OpenAI
    try:
        checks["services"]["openai"] = (
            "ok" if ai_service.is_configured() else "not_configured"
        )
    except Exception as e:
        checks["services"]["openai"] = f"error: {str(e)}"
    
    # Check Redis
    try:
        redis_client.ping()
        checks["services"]["redis"] = "ok"
    except Exception as e:
        checks["services"]["redis"] = f"error: {str(e)}"
    
    # Check Qdrant
    try:
        qdrant_client.get_collections()
        checks["services"]["qdrant"] = "ok"
    except Exception as e:
        checks["services"]["qdrant"] = f"error: {str(e)}"
    
    return checks
```

### 3. Add Proper Dependency Injection
```python
# app/core/dependencies.py
from functools import lru_cache

@lru_cache
def get_ai_service() -> CVExtractionService:
    return CVExtractionService()

@lru_cache
def get_file_parser() -> FileParserService:
    return FileParserService()

# In routers
@router.post("/extract")
async def extract_cv(
    ai_service: CVExtractionService = Depends(get_ai_service),
    file_parser: FileParserService = Depends(get_file_parser),
):
    ...
```

---

## 📚 Additional Resources Needed

1. **Deployment Guide** - How to deploy with Docker/Kubernetes
2. **API Documentation** - OpenAPI/Swagger specs (auto-generated)
3. **Runbook** - Common operational issues & fixes
4. **Architecture Decision Records (ADRs)** - Why certain choices were made
5. **Troubleshooting Guide** - Common errors and solutions

---

## ✅ Next Steps

**What I can help with immediately:**

1. **Implement structured error handling** - I can refactor all routers
2. **Add comprehensive logging** - Set up JSON logging with request tracing
3. **Create test suite** - Build unit + integration tests
4. **Security hardening** - Fix CORS, file upload, webhook verification
5. **Documentation** - Generate API docs, deployment guide, architecture
6. **Performance profiling** - Identify bottlenecks and optimize

**Would you like me to:**
- [ ] Implement any of these fixes directly?
- [ ] Create a prioritized task list for your team?
- [ ] Set up CI/CD pipeline?
- [ ] Create deployment configuration (Docker/K8s)?
- [ ] Write specific security fixes?
- [ ] Generate test fixtures?

---

**Audit completed:** This is a solid foundation with clear paths to production readiness.  
**Time to production:** 2-3 weeks with focused effort on security + testing.
