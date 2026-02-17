# Knowledge Base

Central hub for professional learnings and project insights.

Last updated: Tuesday, February 17, 2026 — 4:00 AM (Asia/Katmandu)

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

- **Status**: AI solutions development for recruitment SaaS platform
- **Focus**: Audit and optimization of existing systems
- **Key Components**: (in progress)
- **Recent Decisions**: (pending)
- **Blockers**: (pending)

## Team Structure (Symbiosis + Telerivet Partnership)

**Symbiosis Solutions:**
- Dipesh (co-founder, AI architecture/vision)
- Akshay Raj Manandhar (co-founder, equal partnership)
- Looza Subedi (junior AI engineer, significant codebase contributions)
- Arun Singh Nepali (operations/customer discovery lead)

**Telerivet Nepal (cross-org partnership):**
- Sony di (team lead)
- Bedanga (sales, market insights)
- Aaditya (business operations)
- Aakib (developer, agent-studio contributions)
- Mabisha (designer + developer)

## Learnings

Insights extracted from daily work:

- **Cross-org governance:** Building SaaS across two organizations requires clear decision frameworks and authority boundaries
- **Team utilization:** Aligning roles to strengths (e.g., Arun's ops+communication for customer discovery) amplifies team effectiveness
- **Discovery-first product development:** Customer interviews before feature decisions reduce speculation and align roadmap to market needs

## Active Decisions

Things we're currently deciding or working through:

- **IP ownership & partnership framework** (CRITICAL, blocks funding/scaling)
  - No formal agreement on Sahayata IP ownership yet
  - No revenue split model defined
  - Target: Legal clarity by end of February
  
- **Cross-org decision-making structure**
  - Establishing Product Council (weekly sync): Dipesh + Looza + Bedanga + Aakib + Mabisha + Arun
  - Product direction authority still being defined

## Active Initiatives

- **Customer Discovery:** Arun starting prospect visits to gather deep market insights
- **Product Council:** First meeting to be scheduled for cross-org alignment
- **IP/Partnership Legal:** Initial conversation with Sony di scheduled

---

This is built from daily journals and conversations. See `journal/` for raw notes.
