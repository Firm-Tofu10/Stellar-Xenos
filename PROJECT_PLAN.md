# Stellar Dogos — Project Plan

**Mod name:** Stellar Dogos  
**Target game:** Stellaris 4.4.x (Pegasus)  
**Installed research/test build:** **Pegasus v4.4.6** (`modsCompatibilityVersion = 4.4`)  
**Vanilla install (read-only):** `C:\Program Files (x86)\Steam\steamapps\common\Stellaris`

This document is the overall goals + current-state record. Detailed pipelines live under `docs/`.

| Doc | Ownership |
|-----|-----------|
| [README.md](README.md) | User-facing install / usage |
| [docs/portrait-workflow.md](docs/portrait-workflow.md) | Image → DDS → Stellaris |
| [docs/portrait-prompts.md](docs/portrait-prompts.md) | AI image-generation prompts |
| [docs/portrait-testing.md](docs/portrait-testing.md) | In-game compatibility matrix |
| [docs/development-roadmap.md](docs/development-roadmap.md) | Phases and next tasks |
| [docs/ai-development-workflow.md](docs/ai-development-workflow.md) | Repomix → ChatGPT → Cursor process |

---

## Certainty labels

| Tag | Meaning |
|-----|---------|
| **CONFIRMED** | Observed directly in the installed Stellaris 4.4.6 environment or verified in-game |
| **ASSUMPTION** | Reasonable design choice not yet independently verified |
| **TARGET** | Desired behavior we are intentionally designing toward |
| **NEEDS VERIFICATION** | Requires additional game testing, repository inspection, or experimentation |

Do not convert assumptions into confirmed facts.

---

## 1. Project goal

**Stellar Dogos** is a Stellaris 4.4.x mod that adds **real-world dogs** as selectable **Mammalian** species portraits.

### Initial scope

- Piglet
- Oakley
- Angus

Designed to support additional dogs later.

### Release goals

| Goal | Status |
|------|--------|
| Users install mod and use included dog portraits (Workshop) | **TARGET** — **NOT READY** |
| Reusable portrait ingestion workflow/tool (no manual Stellaris file editing per dog) | **TARGET** — importer **NOT BUILT** |

---

## 2. Current project state

| Item | Status |
|------|--------|
| Piglet `sd_dog_piglet` | **WORKING** (species creation) |
| Oakley `sd_dog_02` | **WORKING** (species creation) — gold-standard visual |
| Angus `sd_dog_angus` | **WORKING** (species creation) — regenerated ImgHERE art |
| Static `texturefile` mechanism | **CONFIRMED** in Stellaris 4.4.6 (experimental proof) |
| DDS format (256×256 uncompressed 32-bit RGBA, `pfFlags=0x41`) | **CONFIRMED** |
| Transparency / alpha requirements | **CONFIRMED** |
| ImgHERE staging workflow | **CONFIRMED** |
| Automated importer | **NOT BUILT** |
| Full UI compatibility (leaders, council, diplomacy, …) | **NEEDS VERIFICATION** |
| Steam Workshop release | **NOT READY** |

Working implementation lives in:

`experiment/sd_static_portrait_test/`

---

## 3. Development process

Standard loop: **Repomix → ChatGPT audit/plan → Cursor implementation → validation → review → docs/roadmap update → fresh Repomix**.

Full detail: [docs/ai-development-workflow.md](docs/ai-development-workflow.md).

Cursor must not independently redesign architecture or outrun the roadmap.

---

## 4. Vanilla research summary

**CONFIRMED** inspections included portrait categories, sets, species classes, portrait definitions, model textures, asset selectors, sprite configuration, leader backgrounds, and related localisation/config.

**CONFIRMED:**

- Live vanilla species portraits use `entity = …`
- Comments mention `spriteType` / `texturefile` alternatives — not treated as auto-valid
- No live vanilla static `texturefile` species portrait example in this install

**CONFIRMED (experiment):**

- Mod-added static portraits via `texturefile` appear and render in empire/species creation on 4.4.6

Mechanism was proven experimentally, not because vanilla currently uses it for species portraits.

---

## 5. Proof-of-concept architecture

```text
portrait definition (texturefile + no_texture selectors + mammalian greeting)
  → DDS under gfx/models/portraits/sd_static_test/
  → portrait set sd_static_test (species_class = MAM)
  → Mammalian category override appends that set
```

Do not invent additional portrait syntax beyond the working pattern. See [docs/portrait-workflow.md](docs/portrait-workflow.md).

---

## 6. Immediate next task

**Not** the importer.

**Portrait Context Compatibility Audit** — use **Oakley** as the primary test portrait across species / leader / council / government / diplomacy / contacts / factions / events / other UI.

Document results in [docs/portrait-testing.md](docs/portrait-testing.md).

Only after that audit should importer architecture be finalized ([docs/development-roadmap.md](docs/development-roadmap.md) Phase 2 → 3).

---

## 7. Regression protection

- Treat **Piglet** and **Oakley** as protected fixtures
- Do not silently rebuild existing portraits
- Change existing dogs only when a task explicitly requests it
- Prefer before/after SHA-256 checks during asset work

---

## 8. Non-goals (current)

- Custom traits, civics, origins, or dog-specific gameplay systems
- Modifying the vanilla Stellaris installation
- Claiming full portrait-context compatibility before Phase 2
- Claiming Workshop readiness before Phases 8–9
- Building the importer before the compatibility audit

---

## 9. Roadmap pointer

Phases 0–9 (discovery → calibration → compatibility audit → importer → fourth dog → failure tests → docs/UX → release prep → Workshop):  
[docs/development-roadmap.md](docs/development-roadmap.md)
