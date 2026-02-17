# Customer Signal → Sprint Goal Framework
## For Arun: How to Present Customer Discovery

---

## The Problem We're Solving

Right now: Backlog is prioritized by gut feel.

New: Backlog is prioritized by what customers are actually asking for.

**Your job:** Bring customer signals into the room, help the team see what matters, tie each sprint goal to real customer need.

---

## 🎯 What's a "Customer Signal"?

A customer signal is **something you heard from actual customers** that points to:
- A problem they're facing
- A request they made
- A workflow that's broken
- A moment they were confused or frustrated

**Examples:**
- "Three customers this week said the prompt templating is too rigid for their use case"
- "Sales got blocked trying to explain how the RAG pipeline works to a prospect"
- "Customer wants to integrate with Slack but we don't have an API for it"
- "Two customers asked for better error messages when chunking fails"

**Not signals:**
- "I think we should improve performance" (no customer asked)
- "We should refactor the codebase" (not customer-driven)
- "Let's add a feature we think is cool" (speculation, not signal)

---

## 📋 Your Weekly Prep for Monday Planning

**Before Monday 9 AM:**

1. **Review the week** (5 min)
   - What did you talk to customers about?
   - What patterns did you notice?
   - What got repeated?

2. **Write down your top 3 signals** (5 min)
   - Signal #1: [What customers said]
   - Signal #2: [What customers said]
   - Signal #3: [What customers said]

3. **For each signal, write:**
   - **Severity:** How many customers? How urgent? (1-5 scale)
   - **Quote:** What did they actually say? (paraphrase is fine)
   - **Impact:** If we fixed this, what changes for them?
   - **Blocker?** Is this blocking them from using the product right now?

**Example:**
```
SIGNAL #1: Prompt templating is too rigid
- Severity: 4/5 (3 customers, came up in demos)
- Quote: "We want to swap out parts of the prompt for different use cases, but the whole template changes every time"
- Impact: Customers could run multiple variants. Right now they have to modify code.
- Blocker: Not a blocker, but it's slowing down their experimentation

SIGNAL #2: RAG pipeline error messages are opaque
- Severity: 3/5 (2 customers, support ticket)
- Quote: "When chunking fails, we get a generic error. We don't know if it's our data or your system"
- Impact: Customers spend time debugging instead of iterating
- Blocker: Yes, support team can't help them diagnose

SIGNAL #3: No integration with Slack
- Severity: 2/5 (1 customer asked, but nice-to-have)
- Quote: "We'd love to see insights in our Slack channel"
- Impact: Would close a gap in their workflow
- Blocker: No, workaround exists (API call from Zapier)
```

---

## 🗣️ How to Present in Planning Meeting

**In Monday 9 AM planning (5 minutes for this section):**

```
"Here's what I heard from customers this week:

Signal #1 (Severity 4): Prompt templating is too rigid
- Three customers want to swap out parts of prompts without rebuilding the whole template
- Quote: '[customer quote]'
- If we fix this: They can experiment 10x faster

Signal #2 (Severity 3): Error messages are opaque
- Support can't help customers debug. Generic errors aren't useful.
- If we fix this: Faster support resolution, happier customers

Signal #3 (Severity 2): Slack integration would be nice
- One customer asked. Workflow convenience, not blocker.
- If we fix this: Small UX win, one customer happy

My take: Signals 1 & 2 are worth this sprint. Signal 3 is nice but lower priority.
What do you think?"
```

**That's it.** You present, team reacts, you build consensus on which signals to prioritize this sprint.

---

## 🔗 How This Connects to Sprint Backlog

**Your signals → Team's backlog picks**

After you present, the team will:

1. Look at backlog items
2. Ask: "Which of these solve Arun's signals?"
3. Label each item:
   - 🔴 **Red** = Solves signal #1 or #2 (customer-requested)
   - 🟡 **Yellow** = Supports the sprint goal but not a direct signal (testing, docs, setup)
   - 🟢 **Green** = Nice-to-have / tech debt (not tied to signal)

4. Build sprint from Red + Yellow items only (unless sprint is super easy)

5. Sprint goal becomes: **"This week we're [solving signal], shipped by [Red items]"**

**Example sprint goal:**
- *Last sprint:* "Make prompts more flexible and improve error handling" ← vague
- *New sprint:* "Solve flexible prompt templating (Signal #1) and opaque error messages (Signal #2) by shipping: custom prompt sections + detailed chunking errors" ← concrete + customer-connected

---

## 📊 Signal Tracking (Optional)

If you want to track signals over time (optional):

**Create a simple sheet:**

```
| Week | Signal | Severity | Status | Shipped? | Outcome |
|------|--------|----------|--------|----------|---------|
| Jan 20 | Prompt flexibility | 4 | Backlog → Sprint 2 | Yes | Customer ran 3x more experiments |
| Jan 20 | Error messages | 3 | Sprint 2 | Yes | Support response time -30% |
| Jan 20 | Slack integration | 2 | Backlog | No | Deferred to Q2 |
| Jan 27 | [New signal] | [X] | ... | | |
```

This helps you see:
- What signals actually got prioritized
- What moved the needle for customers
- Where prioritization was wrong (signals we shipped that didn't help)

But don't overthink this. Signals in, sprint goals out. That's the main thing.

---

## 💡 Tips for Finding Good Signals

**Where signals come from:**
- **Customer calls:** "We tried to do X, it doesn't work"
- **Support tickets:** Repeated questions/issues
- **Sales demos:** Places where prospects got confused
- **Onboarding:** New customers struggling with specific flows
- **Feedback channel:** Customers proactively told you something

**Bad signals:**
- "I think we should..." (your opinion, not customer request)
- "Competitors have..." (nice context, but not signal)
- "It would be cool if..." (speculation)
- Vague stuff (signal should be specific enough that team knows what to build)

**Good signals:**
- Specific ("customers can't swap out the prompt section" not "prompts are bad")
- Repeated (at least 1-2 times, or blocking someone)
- Tied to customer outcome ("they'll experiment faster" not "it's theoretically better")
- Actionable (team can ship something to address it)

---

## 📝 Your Monday Planning Checklist

**By 8:50 AM Monday:**
- [ ] Written down top 3 signals
- [ ] Severity + quote + impact for each
- [ ] Decided which ones matter most this sprint
- [ ] In the meeting, you'll spend 5 min presenting these

**That's it.**

The team takes those signals and builds the sprint around them.

---

## 🚀 Why This Works

- **Removes gut feel:** Decisions are based on what customers actually said
- **Gives team context:** They know *why* they're building, not just *what*
- **Ties work to impact:** "We shipped this because customers asked for it"
- **Builds feedback loop:** Next month, we check if the sprint actually solved the signal
- **Reduces meetings:** No separate "what should we build?" arguments. Customers decided.

You're not deciding what the team builds (they do). You're bringing the customer voice into the room so the team can decide based on real feedback.

---

## 📞 Questions?

If signals feel vague, ask the customer:
- "What happened when you tried to do X?"
- "How is this blocking your workflow?"
- "How often does this come up?"

This clarifies the signal and helps the team know what "done" looks like.

