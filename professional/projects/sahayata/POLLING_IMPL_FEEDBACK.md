# Agent-API Task Processing Implementation - Updated Feedback

**Date:** Feb 17, 2026  
**Update:** Architecture changed from polling to retry-based (no more polling)  
**Context:** Feedback on implement-polling PR (Feb 12) — now superseded

---

## Architecture Change

**Previous:** Async polling with 50ms intervals (blocked on quick user feedback)  
**New:** Synchronous task execution with exponential backoff retries (better resource efficiency)

This is a significant improvement — retries are cleaner than polling for this use case.

---

## Updated Recommendations

### 1. **Exponential Backoff Retry Logic** (HIGH PRIORITY)
- **Problem:** If `process_agent_response()` fails, response is lost silently
- **Solution:** Retry with exponential backoff (50ms → 100ms → 200ms → 500ms)
- **Implementation:**
  ```python
  @retry(max_retries=3, backoff_factor=2, wait_base=0.05)
  def process_agent_response(assistant_message, user_id, agent_id):
      # Retry on failure with exponential backoff
      # 1st retry: 50ms
      # 2nd retry: 100ms
      # 3rd retry: 200ms
      # If all fail, exception bubbles up
  ```
- **Benefit:** Handles transient failures gracefully; gives services time to recover

### 2. **Task Cleanup (TTL)** (HIGH PRIORITY)
- **Problem:** Task results accumulate in Redis forever → memory bloat
- **Solution:** Auto-expire results after 1-2 hours
- **Implementation:**
  ```python
  celery_app.conf.update(result_expires=3600)  # 1 hour TTL
  ```

### 3. **Circuit Breaker for Telerivet** (MEDIUM PRIORITY)
- **Problem:** If Telerivet API is down, exponential backoff will eventually timeout
- **Solution:** Use circuit breaker to fail fast and alert ops
- **Implementation:** `pybreaker` library
- **Benefit:** Prevents cascading failures; better observability

### 4. **Better Error Handling & User Feedback** (MEDIUM PRIORITY)
- **Problem:** Failed requests leave users confused
- **Solution:** Return meaningful error messages
- **Implementation:**
  ```python
  try:
      result = await execute_agent_task(...)
  except TimeoutError:
      return {"status": "error", "message": "Agent took too long, please try again"}
  except Exception as e:
      logger.error(f"Task failed: {e}")
      return {"status": "error", "message": "Failed to process request"}
  ```

### 5. **Logging & Metrics** (MEDIUM PRIORITY)
- **Problem:** No observability into retry behavior
- **Solution:** Track retry counts, backoff durations, failure rates
- **Implementation:**
  - Log: `retry_attempt=N, backoff_ms=X, task_type=Y`
  - Metrics: `retries_per_task`, `failure_rate_by_service`, `total_backoff_time`

### 6. **Max Retry Limit** (LOW PRIORITY)
- **Problem:** Could retry infinitely in pathological cases
- **Solution:** Cap retries at 3-5 attempts max
- **Implementation:**
  ```python
  @retry(max_retries=3, backoff_factor=2)
  def process_agent_response(...):
      # After 3 retries with exponential backoff (~350ms total), give up
  ```

---

## Implementation Priority

**Phase 1 (This sprint):**
1. Exponential backoff retry logic
2. Task TTL cleanup
3. Error handling for users

**Phase 2 (Next sprint):**
4. Circuit breaker for Telerivet
5. Metrics/logging

**Phase 3 (Later):**
6. Max retry limits (usually automatic with @retry decorator)

---

## Why This Is Better Than Polling

✅ **Simpler code** — No async polling loops  
✅ **More efficient** — No constant Redis checks  
✅ **Natural backoff** — Exponential backoff is the right pattern for retries  
✅ **Better observability** — Retry count is explicit in logs  
✅ **Cleaner error flow** — Exceptions bubble up naturally  

---

## Notes

- Use `tenacity` or `backoff` library for clean @retry decorator
- Test backoff timing: 3 retries with 2x backoff = ~350ms total (50 + 100 + 200)
- Monitor Telerivet response times to validate timeout settings
- Consider jitter in backoff (+ random 0-10ms) to prevent thundering herd
