# Stellar Xeno — Project Plan

**Mod name:** Stellar Xeno  
**Repository / project name:** Stellar Xeno  

**Target game:** Stellaris 4.4.x (Pegasus)  
**Installed research/test build:** **Pegasus v4.4.6** (`modsCompatibilityVersion = 4.4`)  
**Vanilla install (read-only):** `C:\Program Files (x86)\Steam\steamapps\common\Stellaris`

This document is the overall goals + current-state record. Detailed pipelines live under `docs/`.

| Doc | Ownership |
|-----|-----------|
| [README.md](README.md) | User-facing install / usage |
| [docs/portrait-workflow.md](docs/portrait-workflow.md) | Image → DDS → Stellaris |
| [docs/portrait-prompts.md](docs/portrait-prompts.md) | Dog-development AI image-generation prompts (historical) |
| [docs/portrait-generation-prompts.md](docs/portrait-generation-prompts.md) | Authoritative xenotype prompt library |
| [docs/portrait-variety-standard.md](docs/portrait-variety-standard.md) | Universal composition / identity / transparency variety standard |
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

**Stellar Xeno** is a Stellaris 4.4.x project for turning custom reference photographs into selectable species portraits across multiple Stellaris xenotypes.

Dogs were the original development and regression subjects. The current workflow is intended for arbitrary custom portrait subjects and is not limited to dogs.

### Initial development fixtures

- Piglet
- Oakley
- Angus

These (and later dog fixtures) remain important regression/development portraits. The pipeline also supports additional custom subjects and xenotypes.

### Release goals

| Goal | Status |
|------|--------|
| Users install mod and use included / created portraits (Workshop) | **TARGET** — package ready; human upload pending |
| Reusable portrait ingestion workflow/tool (no manual Stellaris file editing per portrait) | **IMPLEMENTED** for production path (`mod/stellar_dogos/`); Workshop package structurally prepared |

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
| Phase 3.1 interactive source intake | **IMPLEMENTED** (`tools/portrait-intake.ps1`) |
| Phase 4 DDS generation | **IMPLEMENTED** (`tools/portrait-dds.ps1`) |
| Phase 5 Stellaris registration | **IMPLEMENTED** (`tools/portrait-register.ps1`) |
| Phase 6 end-to-end pipeline | **IMPLEMENTED** (`tools/portrait-pipeline.ps1`) |
| Phase 7 xenotype selection | **IMPLEMENTED** (`tools/portrait-xenotypes.ps1`) — 12 types including Toxoid; Mam/Avi/Rep/Fun file paths **CONFIRMED**; in-game **NEEDS VERIFICATION** |
| Canonical PNG naming (`dogNN_<name>_<xeno>_stellaris.png`) | **IMPLEMENTED** — xenotype abbreviation in source filename only; DDS/ID unchanged |
| Xenotype image-generation prompt library | **DOCUMENTED** ([docs/portrait-generation-prompts.md](docs/portrait-generation-prompts.md)); Machine & Toxoid Universal prompts **CREATED**; variety standard [docs/portrait-variety-standard.md](docs/portrait-variety-standard.md); Mammalian Universal body still **ABSENT**; Toxoid selector/registration **IMPLEMENTED** |
| Full UI compatibility (leaders, council, diplomacy, …) | **NEEDS VERIFICATION** |
| Steam Workshop release | **PACKAGE READY** — structural prep done; human in-game test + Steam upload remain ([docs/workshop-release.md](docs/workshop-release.md)) |

Working implementation lives in:

`mod/stellar_dogos/`

(`experiment/sd_static_portrait_test/` is retained temporarily as a regression/reference copy.)

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

## 6. Immediate next engineering task

**Phase 2** UI-context compatibility audit (Oakley gold standard), plus human in-game verification of Cedar/Liberty (Mammalian) and Sparrow (Avian) in species creation.

Phases 3.1–7 (intake → DDS → xenotype registration → pipeline) are implemented at the file level. In-game renders for new Phase 6/7 portraits remain **NEEDS VERIFICATION**.

Workshop packaging and portrait variants are explicitly out of scope until later phases.

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
