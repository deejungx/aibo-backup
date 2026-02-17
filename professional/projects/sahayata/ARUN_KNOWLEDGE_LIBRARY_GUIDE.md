# Arun's Knowledge Library Maintenance Guide
## Building the Customer Context for AI Agents

---

## The Problem

Right now: We build agents based on guesses about how customers work.

New: Arun documents *exactly* how customers work, what they use, what they know, what they ask — so agents can be trained on real customer context.

**Your mission:** Be the keeper of customer knowledge. Document the customer's world so we can teach agents to work in it.

---

## 🏗️ What You're Building: The Knowledge Library

A **living document** that captures everything about how customers work:

```
KNOWLEDGE_LIBRARY/
├── Sources/              (Where customers find info)
├── Tools/                (What tools they use daily)
├── Intents/              (What they're trying to do)
├── Workflows/            (How they do it)
├── Common Questions/     (What they ask repeatedly)
└── Domain Expertise/     (What customers know that we don't)
```

This library becomes the **foundation for agent training** and knowledge base preparation.

---

## 📚 1. SOURCES — Where Customers Find Information

**Track:** What sources do customers use to answer their own questions?

**Examples:**
```
CUSTOMER: NEC Consultancy (Education)
├── Internal sources
│   ├── Knowledge base: Past admission requirements by university
│   ├── Email threads: Previous student conversations
│   ├── Spreadsheets: Program timelines, visa requirements
│   └── Team expertise: Individual staff knowledge
├── External sources
│   ├── University websites: Official requirements
│   ├── Government sites: Visa policy (IRCC, UK Visas, etc.)
│   ├── Forums: Student Reddit communities, international forums
│   └── News: Policy changes from official sources
└── Frequency
    ├── Daily: Internal knowledge base, past emails
    ├── Weekly: Government sites for policy changes
    └── Monthly: Forums for student trends
```

**Why this matters:**
- Agent needs to know: "This answer should come from past client data" vs. "This should search the web"
- Tells us what knowledge base we need to build (past emails → indexable docs)
- Shows us what external APIs we need (government data, university APIs)

---

## 🛠️ 2. TOOLS — What Tools Do Customers Use Daily?

**Track:** What's in their workflow stack?

**Examples:**
```
CUSTOMER: NEC Consultancy
├── Communication
│   ├── Email (primary for student contact)
│   ├── WhatsApp (for quick updates)
│   ├── Phone (for urgent clarifications)
│   └── Slack (internal team coordination)
├── Data/Documents
│   ├── Google Sheets (requirements, timelines)
│   ├── Email (storing conversations)
│   ├── PDF files (university info)
│   └── Word docs (templates for replies)
├── Admin/Workflow
│   ├── CRM (if they have one)
│   ├── Calendar (for deadlines, visa dates)
│   ├── Notion/OneNote (internal notes)
│   └── GitHub/Jira (if tech-adjacent)
└── Key integrations they wish existed
    ├── "Connect our CRM to send automated updates"
    ├── "Pull data from university APIs directly"
    └── "Sync visa requirements to a dashboard"
```

**Why this matters:**
- Agent needs integrations to *their* workflow (not a generic workflow)
- Tells us where to pull knowledge from (those spreadsheets, CRMs, documents)
- Shows us what actions agent should take (send WhatsApp, update spreadsheet, log to CRM)

---

## 🧠 3. INTENTS — What Are They Trying to Accomplish?

**Track:** The high-level goals behind customer questions.

**Examples:**
```
CUSTOMER: NEC Consultancy

INTENT #1: Qualification (60% of inquiries)
├── User is asking: "Do I qualify for this program?"
├── What they're really asking: "Is my profile a match? Don't waste my time if not."
├── Context needed: GPA requirements, test scores, work experience requirements
├── Agent should: Collect info → Match to requirements → Give yes/no + next steps

INTENT #2: Timeline Navigation (25% of inquiries)
├── User is asking: "When should I apply? When do I get an answer?"
├── What they're really asking: "Help me plan my timeline."
├── Context needed: Deadlines, processing times, visa timelines
├── Agent should: Tell them deadlines → Work backward → Create plan

INTENT #3: Logistics/Logistics (10% of inquiries)
├── User is asking: "What documents do I need? How do I submit?"
├── What they're really asking: "Make this process simple."
├── Context needed: Checklist of docs, submission method, format requirements
├── Agent should: Provide checklist → Monitor submission → Track status

INTENT #4: Troubleshooting (5% of inquiries)
├── User is asking: "Why was I rejected? What went wrong?"
├── What they're really asking: "Can I fix this and try again?"
├── Context needed: Decision criteria, common rejection reasons, appeal process
├── Agent should: Explain reason → Suggest improvements → Coach for next attempt
```

**Why this matters:**
- Agent responds differently based on intent (not just keyword matching)
- Tells us what knowledge base sections are most critical (prioritize top intents)
- Shows us where to invest in automation (Intent #1 can be 80% automated)

---

## 🔄 4. WORKFLOWS — How Do They Actually Do It?

**Track:** Step-by-step how customers handle a common scenario.

**Examples:**
```
WORKFLOW: NEC Consultancy processes a new student inquiry

Step 1: Receive inquiry (WhatsApp, Email, or Website form)
├── Info captured: Name, email, target program, qualifications
├── Tool: WhatsApp auto-reply or email auto-response
└── Time: Instant

Step 2: Initial qualification (Staff reads & assesses)
├── Question asked: "Do they meet basic requirements?"
├── Data checked: GPA, test scores, experience
├── Tool: Staff searches past docs, reads emails, checks spreadsheet
└── Time: 2-4 hours

Step 3: Send initial response
├── If qualified: "Great! Here's next steps..."
├── If unqualified: "Unfortunately you don't meet requirements, but consider..."
├── Tool: Email template + personalization
└── Time: 5 min

Step 4: Send detailed requirements checklist
├── Documents needed: Transcripts, test scores, essays, etc.
├── Format: Email or WhatsApp with PDF checklist
├── Tool: Email template library
└── Time: 5 min

Step 5: Student submits documents
├── Collection method: Email or online form
├── Storage: Google Drive folder per student
├── Tool: Manual file collection
└── Time: Varies

Step 6: Review & decision
├── Documents reviewed for completeness
├── Decision made: Accept, reject, or request more info
├── Tool: Internal discussion + spreadsheet update
└── Time: 1-2 days

Step 7: Communicate decision
├── Message sent: Accept/Reject + next steps
├── Tool: Email
└── Time: 30 min
```

**Why this matters:**
- Agent can automate Steps 1, 2, 3, 7 (qualification + initial response)
- Agent can help with Step 4 (send checklist intelligently)
- Agent can do Step 5 (collect + organize documents)
- Tells us exactly where agent adds value (which steps are manual today?)

---

## ❓ 5. COMMON QUESTIONS — What Do They Get Asked Over and Over?

**Track:** The FAQ your customer experiences daily.

**Examples:**
```
CUSTOMER: NEC Consultancy

Q1: "Do I qualify for [program]?" (30 times/month)
├── Variants: "Can I apply with [different background]?", "Do I need [test score]?"
├── Current answer process: Manual check against requirements
├── Time spent: 15 min per answer × 30 = 7.5 hours/month
└── Agent opportunity: **HIGH** — 90% automatable

Q2: "What's the deadline for [program]?" (20 times/month)
├── Variants: "When do results come out?", "When can I start?"
├── Current answer process: Check spreadsheet, paste deadline
├── Time spent: 5 min per answer × 20 = 1.7 hours/month
└── Agent opportunity: **HIGH** — 100% automatable

Q3: "What documents do I need to submit?" (18 times/month)
├── Variants: "Do I need [specific document]?", "In what format?"
├── Current answer process: Send standardized checklist + explain
├── Time spent: 10 min per answer × 18 = 3 hours/month
└── Agent opportunity: **HIGH** — 80% automatable

Q4: "Why was I rejected?" (5 times/month)
├── Variants: "Can I appeal?", "What should I improve?"
├── Current answer process: Review case, explain reason, provide feedback
├── Time spent: 30 min per answer × 5 = 2.5 hours/month
└── Agent opportunity: **MEDIUM** — 40% automatable (needs human judgment)

Q5: "Can you process my application faster?" (3 times/month)
├── Variants: "Can you expedite?", "What if I pay more?"
├── Current answer process: Explain standard timeline
├── Time spent: 10 min per answer × 3 = 0.5 hours/month
└── Agent opportunity: **LOW** — Not automatable (policy question)

---

## 🎯 6. DOMAIN EXPERTISE — What Do Customers Know That We Don't?

**Track:** The hidden knowledge living in their heads.

**Examples:**
```
CUSTOMER: NEC Consultancy

Expert #1: Admissions Officer (Senior Staff)
├── Knowledge: "Universities X, Y, Z really value work experience in tech. They'll interview you."
├── How it's used: During qualification, she pulls candidates with tech backgrounds
├── Why agent needs it: Without this, agent qualifies by checklist only ("GPA meets minimum? ✓")
│                      With this, agent says "Your tech background is a big plus here"
└── How to capture: Interview her, document decision patterns

Expert #2: Visa Specialist (Senior Staff)
├── Knowledge: "Processing times have changed. IRCC is now taking 8 weeks instead of 6."
├── How it's used: When giving timeline, she factors in new wait times
├── Why agent needs it: Without this, agent gives outdated timelines
│                      With this, agent gives accurate expectations
└── How to capture: Document policy changes, update monthly

Expert #3: Student Success Manager
├── Knowledge: "Students from India struggle with GMAT timing. They usually study at night."
├── How it's used: When mentoring, she suggests study schedules that work for them
├── Why agent needs it: Without this, agent gives generic advice
│                      With this, agent personalize guidance
└── How to capture: Interview her, document patterns by geography/background
```

**Why this matters:**
- Differentiates your agent from generic chatbots
- Makes agent feel knowledgeable (not like a lookup table)
- Captures institutional knowledge before it leaves the company

---

## 📋 Your Weekly Process

**Every Friday (1 hour):**

1. **Review the week** (15 min)
   - Skim customer conversations
   - Note patterns: repeated questions? Workflows changing? New tools?

2. **Update the knowledge library** (30 min)
   - Add new sources you discovered
   - Document new tools customers are using
   - Record new intents or workflows
   - Capture FAQ variations

3. **Interview one domain expert** (15 min)
   - Quick chat: "What's one thing you learned this week?"
   - Document it in the library

**Output:** Every Friday, you have a fresh snapshot of "how customers work right now"

---

## 🔗 How This Connects to Agent Training

The library becomes the **brief for agent development:**

**Agent Briefing (from your library):**
```
AGENT BRIEF: NEC Consultancy Admissions Bot

INTENTS TO SUPPORT (by frequency):
1. Qualification (60%) — Automate fully
2. Timeline Navigation (25%) — Automate with template
3. Logistics (10%) — Automate with checklist
4. Troubleshooting (5%) — Escalate to human

DATA SOURCES:
- Internal: Past emails (extract to vector DB), spreadsheet of requirements, decision criteria
- External: University APIs, government visa websites, forum trends

TOOLS TO INTEGRATE:
- WhatsApp (primary input)
- Gmail (secondary input)
- Google Sheets (requirements, timelines)
- CRM (if they have one)

DOMAIN KNOWLEDGE:
- Tech background is valued → highlight it
- Processing times: 8 weeks (not 6)
- Students from India study at night → suggest schedules accordingly

WORKFLOWS TO SUPPORT:
- Steps 1-3 (receive → qualify → send initial response): Full automation
- Step 4 (send checklist): Template-based
- Step 5 (collect docs): Partial automation (organize, remind)
- Step 7 (communicate decision): Template-based
```

This brief goes directly to the team building the agent.

---

## 💾 Where to Store This

Create a shared knowledge library:

**Option 1: Shared document (simplest)**
```
Sahayata Knowledge Library
├── NEC Consultancy
│   ├── Sources.md
│   ├── Tools.md
│   ├── Intents.md
│   ├── Workflows.md
│   ├── FAQs.md
│   └── DomainExpertise.md
└── [Other customers]
```

**Option 2: Structured database (scalable)**
If you add more customers, eventually use a shared spreadsheet/DB:
```
| Customer | Category | Item | Details | Usage | Update Freq |
|----------|----------|------|---------|-------|-------------|
| NEC | Sources | University websites | IRCC, UK Visas, ... | Training data | Weekly |
| NEC | Tools | Google Sheets | Requirements matrix | Integration | Ongoing |
```

Start with Option 1 (simple docs), migrate to Option 2 when you have 3+ customers.

---

## 📍 Arun's New Responsibilities

**Original:**
- Bring customer signals → Sprint prioritization

**New (Knowledge Librarian):**
- Bring customer signals → Sprint prioritization
- Maintain knowledge library → Agent training data
- Document customer workflows → Agent design brief
- Capture domain expertise → Agent accuracy

You're basically the **bridge between customer reality and agent design.**

---

## 🚀 Why This Matters

**Without knowledge library:**
- Agents are built on guesses
- Team spends weeks wrong-guessing what customers need
- Agents feel generic and miss context

**With knowledge library:**
- Agents built on customer reality
- Team moves fast (clear brief)
- Agents feel knowledgeable and personalized
- Easy to onboard new customers (reuse templates)

---

## Questions?

- **What if customer workflows change?** Update the library. It's living, not static.
- **What if we don't have domain expertise documented?** Interview the expert. It takes 15 min.
- **What if FAQ changes weekly?** Update it. The whole point is currency.
- **How do we know if the library is working?** Check agent accuracy → if agent is answering questions better, library is working.

You're the source of truth for "how customers work." Make it count.
