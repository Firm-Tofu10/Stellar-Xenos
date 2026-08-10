# Stellar Dogos — AI Development Workflow

This is the project's **standard development process**. Future ChatGPT + Cursor sessions should follow it instead of inventing ad-hoc collaboration patterns.

Related:

- [Development roadmap](development-roadmap.md)
- [Project plan](../PROJECT_PLAN.md)

---

## Roles

### ChatGPT

- Architectural reasoning
- Repository reconstruction from Repomix / docs
- Root-cause analysis
- Research (vanilla Stellaris, modding constraints, external docs)
- Exact implementation planning
- Scope control
- Validation strategy
- Cursor prompt generation

### Cursor

- Implementation only for the specified task
- File modification within that scope
- Local validation
- Test execution when asked
- Changed-file reporting

### Repomix

- Authoritative repository snapshot for future architectural analysis
- Input for ChatGPT repository reconstruction after material changes

### User / live game testing

- Stellaris in-game verification when required
- Final judgment on visual quality and Workshop readiness

---

## Standard loop

```text
Repomix snapshot
  → ChatGPT architecture audit / reconstruction
  → exact implementation plan
  → precise Cursor prompt
  → Cursor implementation
  → local validation + changed-file report
  → ChatGPT review
  → user Stellaris testing (when needed)
  → document newly discovered behavior
  → update roadmap / docs
  → fresh Repomix after significant changes
```

### Step-by-step

1. Identify the next roadmap task ([development-roadmap.md](development-roadmap.md)).
2. Generate a fresh Repomix snapshot when repository state materially changed.
3. ChatGPT reconstructs the repository from docs + Repomix.
4. ChatGPT researches external/current information when required.
5. ChatGPT determines architecture, ownership, exact files, and scope.
6. ChatGPT creates a precise Cursor prompt.
7. Cursor implements **only** the specified task.
8. Cursor reports exact files changed and validation performed.
9. ChatGPT reviews the result.
10. User performs live Stellaris testing when required.
11. Document newly discovered behavior (workflow, testing matrix, prompts).
12. Update the roadmap status.
13. Generate a fresh Repomix snapshot after material changes.

---

## Hard rules

- Do **not** let Cursor independently redesign the architecture.
- Do **not** let implementation outrun the documented roadmap.
- Prefer documentation sync and compatibility audits before automation.
- Protect regression fixtures (Piglet / Oakley) unless a task explicitly targets them.
- Never modify the vanilla Stellaris installation.
- Do not claim in-game success from file wiring alone.

---

## How this applies to Stellar Dogos

| Concern | Owner |
|---------|--------|
| Portrait registration architecture | ChatGPT plans; Cursor applies only approved edits |
| Image generation prompts | Documented in [portrait-prompts.md](portrait-prompts.md); human/AI image tools execute |
| DDS / alpha / ImgHERE pipeline | Documented in [portrait-workflow.md](portrait-workflow.md) |
| In-game compatibility | Human testing recorded in [portrait-testing.md](portrait-testing.md) |
| Portrait importer | Design after Phase 2 audit; implement in Phase 4 |

---

## Immediate process expectation

The next engineering task is **not** the importer.

It is the **Portrait Context Compatibility Audit** (Oakley gold-standard). See [portrait-testing.md](portrait-testing.md) and [development-roadmap.md](development-roadmap.md) Phase 2.
