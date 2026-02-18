# Knowledge Base

Central hub for professional learnings and project insights.

Last updated: Wednesday, February 18, 2026 — 4:00 AM (Asia/Katmandu)

## Projects

### Sahayata

- **Status**: Three-tier system complete. Architecture pivot: **polling removed → exponential backoff with circuit breaker + TTL cleanup.**
- **Key Components**: 
  - agent-studio (Next.js frontend for agent creation/management)
  - agent-api (FastAPI backend for WhatsApp triggers)
  - agent-runtime (Celery workers for agent execution)
- **Architecture**: Split-stack (Supabase auth + External PostgreSQL for business data)
- **Recent Decisions**: 
  - **Exponential backoff retry logic now HIGH PRIORITY** (cleaner than polling, better observability)
  - Organization membership model (users can be members of multiple orgs)
  - **Sprint Ritual System deployed:** 90 min/week (Monday planning, daily async posts, Thursday huddle, Friday retro, monthly recap)
  - **Arun's expanded role:** Customer Signal Lead (3 signals/week) + Knowledge Librarian (knowledge library for agent training)
- **Live Data**: 11,881 agents across multiple organizations
- **Key Integration**: Symbiosis API for LLM inference and storage
- **Team Rituals**: Monday Planning (customer signals drive backlog), Daily Async Posts, Thursday Huddle (demo + unblock), Friday Retro + Knowledge Capture, Monthly Recap (shipped/impact/kudos)
- **Blockers**: 
  - IP ownership agreement still unresolved (blocks funding, customer contracts, scaling confidence)
  - Target: Legal clarity by end of February

**See:** 
- `learnings/sahayata-architecture.md` for complete architecture details
- `projects/sahayata/SPRINT_RITUAL_DESIGN.md` for ritual philosophy + implementation
- `projects/sahayata/ARUN_KNOWLEDGE_LIBRARY_GUIDE.md` for knowledge capture process

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
- Arun Singh Nepali (operations/customer discovery lead → **now also Knowledge Librarian**)

**Telerivet Nepal (cross-org partnership):**
- Sony di (team lead)
- Bedanga (sales, market insights)
- Aaditya (business operations)
- Aakib (developer, agent-studio contributions)
- Mabisha (designer + developer)

## Operational Systems (Aibo)

**Sub-Agents in Production:**

- **Morning News Digest (7 AM daily):** Curated news across AI & Tech, Local News, Business, Global. Direct article links, no Telegram link previews, quote of day.
- **Sahayata Product Manager:** Backlog organization, sprint coordination, cross-org roadmap alignment.
- **LinkedIn Content Agent:** Content strategy, post writing, publishing (awaiting Dipesh input on themes).

**Workspace Structure:**
```
/workspace/
├── personal/           (private notes, not synced externally)
├── professional/
│   ├── kb/             (auto-synced daily at 4 AM)
│   ├── projects/sahayata/  (15+ docs, sprint rituals, guides)
│   ├── projects/recruitnepal/
│   ├── learnings/       (extracted insights)
│   └── journal/         (daily logs)
├── memory/             (MEMORY.md + daily logs)
└── skills/             (asana-api, summarize, tavily, etc.)
```

## Learnings

Insights extracted from daily work:

- **Sprint rituals drive execution:** Team had zero sprint structure. Introducing lean rituals (90 min/week) with customer-driven prioritization removes guesswork and increases accountability.
- **Customer signals = prioritization source of truth:** Arun's role bridging customer voice to backlog decisions shifts from "build what feels right" to "build what solves customer problems first."
- **Knowledge librarian role multiplies agent effectiveness:** Documenting sources, tools, intents, workflows, FAQs, and domain expertise weekly creates training data for agents that differentiates them from generic chatbots.
- **Cross-org governance:** Building SaaS across two organizations requires clear decision frameworks and authority boundaries.
- **Team utilization:** Aligning roles to strengths (e.g., Arun's ops+communication for customer discovery + knowledge capture) amplifies team effectiveness.
- **Lean rituals > heavy ceremonies:** Async-first design + distributed team structure means shorter, focused meetings get attendance; complex ceremonies don't.
- **Appreciation/kudos matter:** Monthly recap with kudos ceremony builds morale in high-pressure cross-org environments.

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

- **Sprint Ritual System Launch:** Monday Feb 18, 2026 — Ready to launch with team announcement (6-doc system delivered)
- **Arun's Dual Role:** Customer Signal Lead (3 signals/week) + Knowledge Librarian (knowledge library maintenance Friday)
- **Customer Discovery:** Arun bringing 3 signals weekly to Monday planning to drive sprint prioritization
- **Sub-Agents Deployed:** 
  - Sahayata Product Manager (backlog org, cross-org coordination, sprint strategy)
  - Morning News Digest (7 AM daily, curated news, direct links, no previews, quote of day)
  - LinkedIn Content Agent (content strategy, writing, posting)
- **IP/Partnership Legal:** Initial conversation with Sony di scheduled (CRITICAL for Feb close)

---

This is built from daily journals and conversations. See `journal/` for raw notes.
