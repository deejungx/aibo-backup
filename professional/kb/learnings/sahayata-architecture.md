# Sahayata Architecture - Full Picture

## Three-Tier System

### 1. **agent-studio** (Next.js Frontend)
- **Purpose:** Admin dashboard for creating, configuring, and managing AI agents
- **Tech:** Next.js 16, TypeScript, Tailwind, Supabase Auth
- **Architecture:** Split Stack
  - Supabase handles **identity** (JWT auth)
  - External PostgreSQL handles **business data** (agents, orgs, configs)
- **Key Features:**
  - Multi-step agent wizard (Profile → Config → Knowledge Base)
  - Organization membership system (users can be members of multiple orgs)
  - Agent CRUD (create, read, update, delete)
  - QR code generation (calls Symbiosis API)
  - PDF knowledge base uploads (proxied to Symbiosis storage)
  - Superuser mode (admins see ALL agents across platform)

### 2. **agent-api** (Python FastAPI Backend)
- **Purpose:** REST API that receives agent triggers and orchestrates responses
- **Tech:** FastAPI, Redis, PostgreSQL
- **Core Flow:**
  1. Receives WhatsApp message → triggers agent
  2. Queries PostgreSQL for agent config
  3. Enqueues task to Redis queue
  4. Returns task_id to caller (recent: polling-based instead of webhooks)
  5. Caller polls for task status/result

### 3. **agent-runtime** (Celery Worker)
- **Purpose:** Asynchronous task execution engine
- **Tech:** Celery, Redis, RAG (embedding models)
- **Core Flow:**
  1. Subscribes to Redis queue
  2. Pulls task (agent_id + message + user_context)
  3. Initializes **Crew agent** with config from DB
  4. Executes crew with tools (web search, image analysis, etc.)
  5. Structures response (AgentMessage)
  6. Stores result in Redis backend

## Data Flow (End-to-End)

```
User (WhatsApp)
    ↓ (scan QR code)
Triggers Agent via agent-api
    ↓ (POST /api/v2/agents)
agent-api queries PostgreSQL for agent config
    ↓
Enqueues task to Redis
    ↓ (polling-based status)
agent-runtime worker picks up task
    ↓
Executes Crew agent with:
    - Persona (persona_prompt)
    - Task (task_prompt)
    - Tools (allowed_actions)
    - Knowledge Base (document_refs + source_urls)
    ↓
Structures response (AgentMessage)
    ↓
Stores in Redis
    ↓ (user polls or webhook)
Response delivered to WhatsApp
```

## Database Schema (PostgreSQL)

### Organizations Table
```sql
- id (UUID, primary key)
- name, website, industry, short_description
- owner_id (links to Supabase user)
- is_active, created_at, updated_at
```

### Agents Table
```sql
- id (UUID, primary key)
- organization_id (FK → organizations)
- name, language, tone
- status (Training/Active/Inactive)
- persona_prompt, task_prompt
- trigger_code (e.g., "ALEX", "TECHSKILLS")
- allowed_actions (JSONB array: ["updateContactTable", "delegateToHuman", "knowledge_search_tool"])
- greeting_message, qr_code_base64
- document_refs (knowledge base PDFs)
- source_urls (web sources)
- model_config (LLM config, routing info)
- greet_image (greeting visual)
- handoff_config (SMS/phone routing for escalation)
- created_at, updated_at
```

### Organization Members Table
```sql
- organization_id, user_id, role (owner/member/viewer)
```

## Current Live Data (From Feb 3 Exports)

- **11,881 agents** across organizations
- **Organizations:** NEC Consultancy, Secured Legal, TechSkills, etc.
- **Sample Agents:**
  - "Alex" (friendly sales assist, Acme Innovations)
  - "TECHSKILLS" receptionist (lead routing, web search + image analysis)
- **Languages:** English + others
- **Tones:** Friendly, professional, energetic
- **Tools:** Knowledge search, nearby search, contact updates, human delegation, web search, image analysis

## Recent Work (Polling vs Webhooks)

- **Branch:** agent-api/implement-polling
- **Change:** Moving from webhook-based callbacks to polling-based task status
- **Why:** Polling gives better control over retry logic and handles unreliable callbacks
- **Implementation:** Client polls `/api/v2/agents/{agent_id}/status` for task result

## Connections

1. **agent-studio** → **PostgreSQL** (read/write agent configs)
2. **agent-studio** → **Symbiosis API** (QR code generation, PDF storage)
3. **agent-studio** → **Supabase** (user auth)
4. **agent-api** → **PostgreSQL** (fetch agent configs)
5. **agent-api** → **Redis** (task queuing)
6. **agent-api** → **agent-runtime** (via Redis queue)
7. **agent-runtime** → **PostgreSQL** (read agent config, tools)
8. **agent-runtime** → **Symbiosis API** (LLM inference via Crew)

## Key Insights

- **Scalability:** Celery + Redis allows unlimited concurrent agents
- **Multi-tenancy:** Organization + membership model isolates data per customer
- **Flexibility:** Agents are fully configurable (tone, tools, knowledge base, routing)
- **Integrations:** Supabase auth, Symbiosis LLM/storage, WhatsApp triggers
- **Modern Stack:** Split-stack frontend (Supabase), Python backend, asyncworkers

---

This is a **complete B2B SaaS platform** for AI agent orchestration. The architecture is designed for:
- Per-organization customization
- Asynchronous task processing
- Multi-model agent support (via Crew framework)
- Enterprise routing & escalation (handoff configs)
