# Multi-Instance Sync Setup

## Current Setup

### MacBook Pro (Primary Instance)
- **Workspace:** `/Users/dipesh/.openclaw/workspace`
- **Role:** Primary machine, main work happens here
- **Git:** Local repo (origin)

### Titan (Desktop PC - Secondary Instance)
- **Workspace:** Separate workspace directory (TBD location)
- **Role:** Secondary/parallel work, background tasks
- **Git:** Separate local repo

---

## Sync Strategy: Git-Based Pull/Push

**Why Git:**
- Version control + history
- Can handle merge conflicts
- Works across networks
- Easy to automate with cron

**How it works:**
1. Create a shared Git repository (GitHub/GitLab - public or private)
2. Both MacBook and Titan push/pull from this central repo
3. Cron jobs run on both machines to sync periodically (e.g., every 30 min)

### Setup Steps

**1. Create Central Repo (One-Time)**
```bash
# On GitHub, create: dipesh-workspace-sync (public or private)
# This becomes the central source of truth
```

**2. MacBook Setup**
```bash
cd /Users/dipesh/.openclaw/workspace
git remote add origin https://github.com/dipesh-jung/dipesh-workspace-sync.git
git branch -M main
git push -u origin main
```

**3. Titan Setup**
```bash
# Clone the shared repo into Titan's workspace
git clone https://github.com/dipesh-jung/dipesh-workspace-sync.git ~/path/to/titan/workspace
```

**4. Set Up Sync Cron Jobs**

On both machines, run sync every 30 minutes:

**MacBook (`~/.openclaw/cron-sync-macbook.sh`):**
```bash
#!/bin/bash
cd /Users/dipesh/.openclaw/workspace
git pull origin main --no-edit 2>/dev/null
git add -A 2>/dev/null
git commit -m "Auto-sync from MacBook: $(date +'%Y-%m-%d %H:%M')" 2>/dev/null
git push origin main 2>/dev/null
```

**Titan (`~/titan/cron-sync-titan.sh`):**
```bash
#!/bin/bash
cd ~/path/to/titan/workspace
git pull origin main --no-edit 2>/dev/null
git add -A 2>/dev/null
git commit -m "Auto-sync from Titan: $(date +'%Y-%m-%d %H:%M')" 2>/dev/null
git push origin main 2>/dev/null
```

**Cron entry (both machines):**
```bash
*/30 * * * * /path/to/cron-sync-script.sh
```

---

## Sync Conflict Strategy

**When conflicts occur (rare):**
- Both machines pulled latest before making changes
- Conflicts only if both edit same file simultaneously
- **Resolution:** Keep both versions or manual merge

**Simple strategy (for now):**
- MacBook is "primary" — if conflict, MacBook version wins
- Titan syncs ~5 min after MacBook pushes
- Minimal conflict risk

---

## What Syncs Between Instances

**Synced automatically:**
- `SOUL.md` — Your identity
- `USER.md` — User context
- `MEMORY.md` — Long-term memory
- `professional/` — All project files
- `professional/projects/sahayata/` — Sahayata backlog + team docs
- `professional/kb/` — Knowledge base (learnings, journal)
- Git commits from both machines

**NOT synced (local only):**
- `.openclaw/` config (each machine has its own)
- `skills/` (can be different versions on each machine)
- `memory/heartbeat-state.json` (machine-specific)

---

## Workflow Examples

### Example 1: MacBook → Titan
1. You work on MacBook (edit `GOVERNANCE.md`)
2. Commit locally
3. Cron job pushes to GitHub at 10:30 AM
4. Titan cron job pulls at 10:35 AM
5. You check Titan and see updated `GOVERNANCE.md`

### Example 2: Parallel Work
1. MacBook: Working on product backlog
2. Titan: Running analysis on code repos
3. Both machines sync every 30 min
4. You can switch between machines knowing context is fresh

### Example 3: Conflict (Rare)
1. Both machines edit `professional/kb/KNOWLEDGE_BASE.md` simultaneously
2. One pushes first (wins), other gets merge conflict
3. Git marks conflict, next pull shows both versions
4. Manual resolution needed (or just keep MacBook version)

---

## Multi-Instance Workflow Rules

**Golden Rules:**
1. **Always sync before switching machines** (cron does this automatically)
2. **Commit often** (so changes are pushed regularly)
3. **Check git status** if something feels off
4. **MacBook is primary** (if conflict, MacBook version is authoritative)

**When using both in parallel:**
- MacBook: Interactive work, customer calls, real-time decisions
- Titan: Background analysis, long-running tasks, async work

---

## Implementation TODO

- [ ] Create central GitHub repo
- [ ] Set up MacBook sync script + cron
- [ ] Set up Titan sync script + cron
- [ ] Test first sync (manual push/pull)
- [ ] Verify cron jobs running
- [ ] Document in workspace

---

## Commands to Manage Sync

**Manual sync (if needed):**
```bash
cd /workspace/path
git pull origin main
git add -A
git commit -m "Manual sync"
git push origin main
```

**Check sync status:**
```bash
git status
git log --oneline -5  # see recent commits
```

**Disable sync temporarily:**
```bash
# Remove cron job or rename script
```

**Force MacBook version (conflict resolution):**
```bash
git checkout --theirs .  # keep incoming (GitHub version)
git checkout --ours .    # keep local (your version)
```
