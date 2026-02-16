# Multi-Instance Setup

## Current Instances

### MacBook Pro (Primary)
- **Host:** Dipesh's MacBook Pro (local)
- **Status:** Active
- **Context:** Full project context (all SOUL.md, USER.md, professional/ files)
- **Skills:** All available

### Titan (Desktop PC)
- **Host:** Titan (Dipesh's desktop)
- **Status:** New, needs setup
- **Context:** Needs sync with MacBook instance
- **Goal:** Connect both instances so they share context and can coordinate

---

## Context Synchronization

**What needs to sync between instances:**
- `SOUL.md` — Identity + vibe
- `USER.md` — User context
- `MEMORY.md` — Long-term memory (when in main session)
- `professional/` — All project files, knowledge base
- `SUBAGENTS.md` — Sub-agent registry

**How to sync (manual for now):**
1. Commit all changes on MacBook (`git add -A && git commit`)
2. Push to Git (if repo is remote)
3. Clone/pull on Titan
4. Both instances now have same workspace context

**Future: Automated sync**
- Could use git-based sync (pull before each session)
- Or cloud sync (Dropbox, iCloud, Google Drive)
- Or OpenClaw gateway bridging (if available)

---

## Titan Connection TODO

- [ ] Set up OpenClaw on Titan
- [ ] Install skills (asana-api, etc.)
- [ ] Sync workspace from MacBook
- [ ] Test context loading
- [ ] Set up automated sync

---

## Multi-Instance Workflow

**When to use MacBook vs. Titan:**
- **MacBook:** Primary work, interactive sessions, professional work
- **Titan:** Long-running tasks, background analysis, parallel work

**Coordination:**
- Check which instance is active before starting work
- Use Git to stay in sync
- Both instances access same workspace via sync

---

**Note:** Once Titan is set up, you'll have me running on both machines with shared context. This enables parallel work (e.g., one instance working on discovery notes while the other analyzes code).
