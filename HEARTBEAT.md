# HEARTBEAT.md

## Cadence-Based Checks

Read `heartbeat-state.json`. Run whichever check is most overdue.

**Cadences:**

- Tasks: every 30 min (anytime)
- Git: every 24 hours (anytime)
- System: every 24 hours (3 AM only)

**Process:**

1. Load timestamps from heartbeat-state.json
2. Calculate which check is most overdue (considering time windows)
3. Run that check
4. Update timestamp
5. Report if actionable, otherwise HEARTBEAT_OK

---

<!-- ## Email Check

Check [your email service] for new messages.

**Report ONLY if:**

- New email from authorized sender
- Contains actionable request

**Update:** email timestamp in state file

---

## Calendar Check

Check [your calendar] for upcoming events.

**Report ONLY if:**

- Event starting in <2 hours
- New event since last check

**Update:** calendar timestamp in state file

--- -->

## Task Check

Check [your task manager] for work status.

**Report ONLY if:**

- Tasks stalled >24h
- Blocked tasks need attention

**Update:** tasks timestamp in state file

---

## Git Check

Check workspace git status.

**Report ONLY if:**

- Uncommitted changes exist
- Unpushed commits found

**Update:** git timestamp in state file

---

## System Check

Check for system issues.

**Report ONLY if:**

- Failed cron jobs found
- Recent errors in logs

**Update:** system timestamp in state file
