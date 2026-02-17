# Sahayata Onboarding & Briefing Session
## February 18, 2026 • 11 AM (50 minutes)

**Attendees:** Dipesh, Rashika (new: investor/engineer + AI/data specialist), Akshay, Arun (catching up)

**Format:** Lean & focused. Every minute counts.

---

## 🎯 Session Goals

1. **Rashika:** Understand project scope, market opportunity, team structure, tech stack → build excitement for potential investment/partnership
2. **Akshay & Arun:** Get current on project progress, decisions, sprint system, recent work
3. **Team:** Align on direction, clarify roles, establish shared understanding

---

## 📋 Session Structure (50 minutes) — Lean & Tight

### **Segment 1: Problem + Market (4 min)**

**Opening (hard-hitting):**
"Education consultancies in Nepal spend 10+ hours/week answering the same questions over and over. 'Do I qualify?', 'What documents?', 'When's the deadline?'. Our bet: AI handles this. Frees up consultants to do real work—mentoring, relationships. Market: 200+ consultancies. Unit economics work. First customer in 8 weeks."

**For Rashika:** "This is a B2B SaaS play with clear unit economics in an untapped market."

**Time: 4 min**

---

### **Segment 2: Solution in 60 Seconds (3 min)**

**Quick architecture overview:**
```
Inquiry → Agent-API (queues) → Agent-Runtime (processes)
         → LLM with knowledge library → Response back
```

**Key points:**
- Agent-Studio (frontend), Agent-API (backend, FastAPI), Agent-Runtime (workers, Celery)
- Multi-tenant. One agent per consultancy. Isolated knowledge.
- Responses in <2 seconds.

**Time: 3 min**

---

### **Segment 3: Live Demo (15 min)** ⭐ **[NON-NEGOTIABLE]**

**What:** Show the system working (this is your credibility moment)

**Demo options:**
- **Best:** Live test inquiry → agent responds with qualification + next steps
- **Good:** Screen share Agent-Studio + sample conversation
- **Acceptable:** Quick walkthrough of UI + knowledge library

**Narration:**
"Inquiry comes in. Agent qualifies automatically. Consultant sees it in dashboard. Done. No manual work."

**Time: 15 min**

---

### **Segment 4: Why It Works — Arun's Discovery (6 min)**

**Hand to Arun (2 min):**
"Here's what I've learned from customers this week: [X customers want Y feature], [Z is the biggest pain point]..."

**Dipesh bridges (1 min):**
"Arun brings customer signals. Team prioritizes by real need, not guesses. Knowledge library (how consultancies actually work) becomes agent training data."

**Why it matters:**
- Not building a generic chatbot
- Building consultancy-specific knowledge
- Customer-driven product decisions

**Time: 6 min**

---

### **Segment 5: Team + Blockers (10 min)**

**Quick team intro:**
- Symbiosis: Dipesh (strategy), Akshay (engineering), Looza (ops)
- Telerivet: Sony di + team (platform support)
- Sprint system launches Monday (customer signals → sprint goals)

**Honest blockers (2 min):**
- **IP ownership:** Symbiosis + Telerivet need legal clarity (Dipesh sorting this month)
- **First paying customer:** Target week 12
- **Tech debt:** Agent-API improvements underway

**For Rashika:** "This is what investors need to know. We're shipping, aligned, but real blockers exist."

**Time: 10 min**

---

### **Segment 6: Next Steps (2 min)**

**Clear asks:**
- **Rashika:** Optional code review this week, 1-on-1 next week on partnership/investment
- **Akshay/Arun:** Sprint 1 Monday 9 AM planning
- **All:** See you Monday

**Close strong:** "We're 4 weeks in. First customer in 8 weeks. This is just the beginning."

**Time: 2 min**

---

## 📌 Pre-Call Checklist

- [ ] Test screen share
- [ ] Have Agent-Studio or demo ready
- [ ] Send link 10 min before
- [ ] Quick sync with Arun: "Be ready with 2-3 customer insights"

---

## 🎯 The Win

You have **50 minutes** to:
1. Show Rashika the opportunity (4 min)
2. Prove it works (15 min demo)
3. Show why it's defensible (Arun's customer work)
4. Be honest about blockers
5. Close with momentum

**Go get it.** 🚀

---

## 💡 Success Tips

✅ **Demo is everything** — 15 min invested here = credibility for Rashika
✅ **No slides** — Just talk and demo
✅ **Arun owns his story** — Let him speak to discovery (5 min)
✅ **Honest about blockers** — Shows maturity, not weakness
✅ **Hard stop at 50 min** — Respect everyone's time

---

## 🎬 Session Flow (TL;DR)

1. **Problem + Market** (4 min) — Hook
2. **Solution** (3 min) — Architecture in plain English
3. **Demo** (15 min) — Credibility moment
4. **Arun's Work** (6 min) — Why it's customer-driven
5. **Team + Blockers** (10 min) — Honesty + clarity
6. **Next Steps** (2 min) — Close strong

**Total: 40 min core + 10 min for Q&A/breathing room = 50 min**
