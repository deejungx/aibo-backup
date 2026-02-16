# Knowledge Base

Central hub for professional learnings and project insights.

Last updated: (auto-filled daily at 4am)

## Projects

### Sahayata

- **Status**: Three-tier system complete. Polling implementation on implement-polling branch.
- **Key Components**: 
  - agent-studio (Next.js frontend for agent creation/management)
  - agent-api (FastAPI backend for WhatsApp triggers)
  - agent-runtime (Celery workers for agent execution)
- **Architecture**: Split-stack (Supabase auth + External PostgreSQL for business data)
- **Recent Decisions**: 
  - Moving from webhook callbacks to polling-based task status (better control, handles unreliable callbacks)
  - Organization membership model (users can be members of multiple orgs)
- **Live Data**: 11,881 agents across multiple organizations
- **Key Integration**: Symbiosis API for LLM inference and storage
- **Blockers**: (none identified yet)

**See:** `learnings/sahayata-architecture.md` for complete architecture details

### RecruitNepal

- **Status**: 
- **Key Components**: 
- **Recent Decisions**: 
- **Blockers**: 

## Learnings

Insights extracted from daily work:

- (added daily)

## Active Decisions

Things we're currently deciding or working through:

- (tracking decisions)

---

This is built from daily journals and conversations. See `journal/` for raw notes.
