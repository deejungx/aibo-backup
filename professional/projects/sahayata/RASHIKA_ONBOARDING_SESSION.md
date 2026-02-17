# Sahayata Onboarding & Briefing Session
## February 18, 2026 • 11 AM (60-90 min)

**Attendees:** Dipesh, Rashika (new: investor/engineer + AI/data specialist), Akshay, Arun (catching up)

---

## 🎯 Session Goals

1. **Rashika:** Understand project scope, market opportunity, team structure, tech stack → build excitement for potential investment/partnership
2. **Akshay & Arun:** Get current on project progress, decisions, sprint system, recent work
3. **Team:** Align on direction, clarify roles, establish shared understanding

---

## 📋 Session Structure (90 minutes)

### **Segment 1: Icebreaker + Context (10 min)**

**What:** Quick intro round + problem statement

**Talking Points:**
- "Rashika, welcome! You're an AI/data specialist — perfect timing. Here's the problem we're solving..."
- **The Problem:** Education consultancies spend 10+ hours/week answering repetitive student inquiries (qualification checks, timeline questions, document checklists)
- **Our Bet:** AI agents can handle 30-40% of these automatically → free up consultants to do mentoring + relationship building
- **Why now:** Education sector in Nepal is exploding. Digital transformation is happening. Consultancies are manually doing work that AI can automate.

**Engagement Hook:** "Rashika, you work in AI/data communities — have you seen this pattern in other industries?"

**Time:** 10 min

---

### **Segment 2: Market Opportunity (8 min)**

**What:** Why Sahayata exists, GTM strategy, customer validation

**Talking Points:**
- **Market:** 200+ education consultancies in Nepal (Tier 2-3 cities initially)
- **Unit Economics:** Each consultancy handles 50+ inquiries/month. Our agent saves 8-10 hours/week → ~$100-150/month value (in their time)
- **GTM:** Start with 1 paying customer by week 12 (customer discovery in progress via Arun)
- **Validation:** Initial conversations show strong interest ("Yes, this would help")
- **Defensibility:** Not building a generic chatbot — building *consultancy-specific* knowledge (their workflows, policies, domain expertise)

**Why for Rashika:** "This is a B2B SaaS play with clear unit economics and an untapped market. Plus, the AI/data challenges are real — handling multi-source knowledge, extracting workflows from unstructured customer data."

**Why for Akshay/Arun:** "We're not guessing. Arun's been doing customer discovery. We know the pain is real."

**Time:** 8 min

---

### **Segment 3: Architecture Deep Dive (12 min)**

**What:** How the system works (tech + product)

**Flow Diagram (describe verbally + show in screen share if possible):**

```
Customer Inquiry (WhatsApp/Email)
         ↓
Agent-API (FastAPI) receives & queues task
         ↓
Agent-Runtime (Celery) processes task
         ↓
Invokes LLM (Claude) with:
  - Customer context (from knowledge library)
  - Qualification logic (from Arun's signals)
  - Latest policies (from knowledge library)
         ↓
LLM generates response
         ↓
Agent sends back (auto-reply via WhatsApp/Email)
```

**Talking Points:**
- **Frontend:** Agent-Studio (Next.js) — consultancies configure agents, view analytics
- **Backend:** Agent-API (FastAPI) with task queuing — handles 1000s of concurrent inquiries
- **Workers:** Agent-Runtime (Celery) — runs LLM inference, integrations
- **Knowledge Base:** Vector DB (RAG) — stores customer workflows, policies, past interactions
- **Architecture principle:** "One agent per consultancy" — isolated knowledge + fast startup

**Why for Rashika:** "We're doing multi-tenant agent architecture at scale. Data challenges include: customer knowledge extraction, privacy per tenant, real-time updates."

**Why for Akshay/Arun:** "This is what we're building. Live demo next segment."

**Time:** 12 min

---

### **Segment 4: Live Demo (15 min)** ⭐

**What:** See the system in action (or walkthrough if live demo isn't possible)

**Demo Flow (pick one):**

**Option A: Live (if you have a test env)**
1. Show Agent-Studio interface (customer dashboard)
2. Send test inquiry to agent (via WhatsApp bot or API call)
3. Show agent responding with qualification + next steps
4. Show analytics/audit log

**Option B: Walkthrough**
1. Screen share Agent-Studio interface
2. Walk through: "A new inquiry comes in → API receives it → Runtime processes it → Response goes back"
3. Show sample conversation (real or mock)
4. Show knowledge library (sources, intents, workflows)

**Talking Points:**
- "This agent handles the boring work. The human handles the important stuff."
- "Notice how we don't just respond — we're collecting info for future inquiries (each conversation builds knowledge)"
- "Speed matters: Responses in <2 seconds. Consultancies get instant replies instead of 2-day turnarounds"

**Why for Rashika:** "See the product working. See the potential."

**Why for Akshay/Arun:** "This is what we shipped. This is what's live (or in beta)."

**Time:** 15 min

---

### **Segment 5: Meet Arun's Role + Knowledge Library (10 min)**

**What:** How customer insight drives product

**Talking Points (Dipesh intro, then hand to Arun):**
- **Arun's job:** Customer discovery + knowledge library maintenance
- **Customer signals:** Weekly, Arun brings 3 customer signals → team prioritizes by customer need (not gut feel)
- **Knowledge library:** Arun documents how consultancies work (sources, tools, intents, workflows, FAQs, domain expertise)
  - This becomes the foundation for agent training
  - Example: "Customer says prompts are too rigid. Agent is then trained to handle flexible prompt templating."
  - Example: "Support takes 30 min to explain visa timelines. Arun captures policy → agent automates it."

**Arun speaks:** "Here's what I've learned so far from [X customers]..."

**Why for Rashika:** "This is how we build a product that actually works. Data-driven, customer-obsessed. Not building features in a vacuum."

**Why for Akshay:** "Arun's been grinding. This work is what unblocks engineering."

**Why for Arun:** "Validation that the work matters. Audience to your insights."

**Time:** 10 min

---

### **Segment 6: Team Structure & Sprint System (8 min)**

**What:** Who does what, how we work together

**Talking Points:**
- **Symbiosis + Telerivet Partnership** (explain cross-org setup)
  - Symbiosis: Dipesh (strategy/CEO), Akshay (engineering), Looza (ops/design)
  - Telerivet: Sony di, Bedanga, Aaditya, Aakib, Mabisha (platform support + integrations)
- **Sprint Rhythm** (new system, launching Monday):
  - Monday Planning (9 AM): Arun presents customer signals → team picks sprint goal
  - Daily async posts (Yesterday/Blocker/Today)
  - Thursday Huddle: Demo + unblock
  - Friday Retro + kudos
  - Monthly Recap (60 min): What shipped, customer impact, team appreciation
- **Rashika's potential role:** AI/data engineering + investor perspective

**Why for Rashika:** "You'd fit here. We're organized, customer-driven, and shipping."

**Why for Akshay:** "Here's how we're staying coordinated despite being distributed."

**Why for Arun:** "Your signals directly drive the sprint."

**Time:** 8 min

---

### **Segment 7: Blockers & Open Questions (10 min)**

**What:** Honest conversation about challenges

**Talking Points:**
- **IP Ownership (legal blocker):** Symbiosis + Telerivet partnership — need legal clarity on who owns what. Impacts: funding, customer contracts, scaling confidence.
  - **Action:** Dipesh to have conversation with Sony di (this month)
- **Product-Council Decision Framework:** Who makes final calls across orgs? (Partially resolved, but need reinforcement)
- **First Paying Customer Timeline:** Need to hit 1 paying customer by week 12 (Arun's discovery driving this)
- **Tech Debt:** Agent-API polling → exponential backoff (Looza implementing)

**Open floor:** "What questions do you have? What concerns?"

**Why for Rashika:** "Be transparent. Investors want to see honesty about blockers."

**Why for Akshay/Arun:** "Nothing hidden. We're aligned on challenges."

**Time:** 10 min

---

### **Segment 8: Next Steps & Commitment (7 min)**

**What:** Clear action items after the call

**Talking Points:**
- **For Rashika:** 
  - [ ] Spend time with codebase (Agent-Studio, Agent-API) if interested
  - [ ] Join Slack/Discord for team updates
  - [ ] Optional: Sit in on Friday Retro (see team culture)
  - [ ] Let's sync 1-on-1 next week on potential partnership/investment terms
- **For Akshay:**
  - [ ] Sprint 1 launches Monday 11 AM — be ready for planning
  - [ ] Review SPRINT_RITUAL_DESIGN.md if you haven't
  - [ ] Help onboard team on new ritual system
- **For Arun:**
  - [ ] Continue customer discovery (3-5 visits this week)
  - [ ] Prepare signals for Monday planning
  - [ ] Share knowledge library template with team
- **For Team:**
  - [ ] Monday 9 AM Sprint 1 Planning with full team
  - [ ] Rashika to join if interested (optional for this week)

**Time:** 7 min

---

## 💡 Engagement Tips

### **Keep it interactive:**
- Ask Rashika questions ("What would you prioritize first?", "How would you approach the data problem?")
- Ask Akshay/Arun for updates ("Akshay, what's the biggest technical challenge right now?")
- Pause after each segment for questions (don't make it a monologue)

### **Show, don't tell:**
- Live demo > PowerPoint
- Real customer quotes > generic pain points
- Arun's actual observations > abstract "customer-driven"

### **Make it personal:**
- Introduce Rashika to the team (brief background)
- Let Arun speak to his discovery work (he owns that)
- Let Akshay share technical wins

### **End on momentum:**
- "We're 4 weeks in. First customer validation in 8 weeks. This is just the beginning."
- "Rashika, we'd love to have you involved. Let's talk specifics next week."

---

## 📌 Session Checklist (Before 11 AM)

- [ ] Test screen share (demo)
- [ ] Have Agent-Studio open (or walkthrough prepared)
- [ ] Have this doc handy (talking points)
- [ ] Send Slack reminder 15 min before (with Zoom/Google Meet link)
- [ ] Quick sync with Arun beforehand ("Be ready to share discovery insights")
- [ ] Have Rashika's background/interests noted (for personalization)

---

## 🎬 Session End (Hard Stop at 90 min)

"Thanks everyone. This was great. Rashika, excited to have you involved. Akshay/Arun, let's execute Monday. See you at Sprint Planning."

---

## Post-Session (Optional)

- Send **1-page summary** to attendees (problem, solution, sprint 1 goals, next milestones)
- Share Rashika's intro with Slack/Discord (make her feel welcome)
- Sync 1-on-1 with Rashika later in the week (investment/partnership terms)
- Thank Arun publicly for discovery work (builds morale)
