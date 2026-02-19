# 🧠 Workspace Consolidation (Nightly Sleep)

## Concept

Like human sleep, where your brain consolidates memories, reorganizes thoughts, and clears clutter — your workspace needs the same.

**The old way:** Auto-create files in kb/ directory (messy, creates garbage)

**The new way:** Run a nightly agent that:
- **Maps** what exists (scan structure)
- **Organizes** using ontology (build knowledge graph)
- **Cleans** duplication & broken references
- **Reports** on organization state
- **Doesn't create** new files (consolidation, not expansion)

---

## How It Works

**Schedule:** 11:00 PM daily (Asia/Katmandu)

**Process:**
1. Scans workspace (personal/, professional/, scripts/, logs/)
2. Extracts entities using ontology:
   - Projects (sahayata, etc)
   - People (Dipesh, Arun, team)
   - Tasks (from TODO/FIXME/BLOCKED)
   - Documents (key files like MEMORY.md, SOUL.md)
   - Events (milestones, deadlines)
3. Builds typed knowledge graph (memory/ontology/graph.jsonl)
4. Checks for:
   - Orphaned files (misplaced)
   - Duplicates (same content in multiple places)
   - Broken references
   - Stale content
5. Reports findings + organization state (no new files created)

---

## What Gets Organized

- **Projects:** Grouped by active/archived, with owners/blockers
- **People:** Team members with roles and relationships
- **Tasks:** Prioritized by status (blocked, in-progress, done)
- **Documents:** Categorized by type (memory, kb, journal, projects)
- **Timeline:** Events/milestones mapped to dates

---

## What Doesn't Happen

- ❌ No new .md files created in kb/ or personal/
- ❌ No duplication of existing content
- ❌ No deletion of files (consolidation, not cleanup)
- ❌ No interruption during the day

---

## Why Ontology?

The ontology skill gives us:
- **Typed entities** (Project, Person, Task, Document, Event)
- **Relations** (project → owner, person, tasks)
- **Constraints** (type checking, validation)
- **Queryability** (what depends on what?)
- **Composability** (other agents can read the graph)

Instead of ad-hoc file syncing, we have a **structured, queryable knowledge graph** of your entire workspace.

---

## Output Example

```
🧠 WORKSPACE CONSOLIDATION REPORT

ENTITIES FOUND:
- Projects: 1 active (Sahayata), 0 archived
- People: 7 mapped (Dipesh, Arun, Sony, Bedanga, etc)
- Tasks: 12 active, 3 blocked
- Documents: 156 total (47 memory, 89 professional, 20 other)
- Events: 4 upcoming (Sprint Monday, Product Council, etc)

ORGANIZATION STATE:
✅ Personal/professional separation: clean
✅ Sahayata team structure: coherent
⚠️  3 TODO items without owner assignment
⚠️  2 files in wrong directory (suggest move)
✅ No broken references detected

ONTOLOGY GRAPH:
- Stored: memory/ontology/graph.jsonl
- Entities: 25 (5 projects, 7 people, 8 tasks, 5 documents)
- Relations: 43 (owns, assigned_to, blocks, references, etc)
- Last updated: 2026-02-19 23:00:00

RECOMMENDATIONS:
- Assign owner to "Multi-Instance Sync" (currently unowned)
- Archive completed sprint documentation (Q1 completed sprints)
```

---

## Files

**Ontology storage:** `memory/ontology/graph.jsonl` (append-only)  
**Schedule:** 11 PM Asia/Katmandu, daily  
**Type:** Isolated agent (runs in background, announces results)  
**Triggers:** Automatic (nightly) + on-demand

---

## Removed

❌ Old "Daily Professional Knowledge Base Sync" (4am)
- Was creating new files
- Now replaced by unified workspace consolidation

---

_Workspace consolidation enabled: Feb 19, 2026_  
_Next sleep cycle: Feb 20, 2026 at 11:00 PM_
