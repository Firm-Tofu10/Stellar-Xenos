# Stellar Dogos

Stellaris **4.4.x** mod that adds real-world dogs as selectable **Mammalian** species portraits.

Current dogs: **Piglet**, **Oakley**, **Angus**.

---

## Status

| Item | State |
|------|--------|
| Species creation portraits | Working (static `texturefile` path confirmed on Pegasus **v4.4.6**) |
| Automated portrait importer | Not built yet |
| Full UI compatibility (leaders, diplomacy, …) | Not fully verified — see [docs/portrait-testing.md](docs/portrait-testing.md) |
| Steam Workshop | Not ready |

Authoritative planning and session memory:

- [PROJECT_PLAN.md](PROJECT_PLAN.md)
- [docs/development-roadmap.md](docs/development-roadmap.md)
- [docs/portrait-workflow.md](docs/portrait-workflow.md)
- [docs/ai-development-workflow.md](docs/ai-development-workflow.md)

---

## Enable the current experiment mod

The working implementation is still under the experiment folder:

`experiment/sd_static_portrait_test/`

1. Ensure `Documents\Paradox Interactive\Stellaris\mod\` exists.
2. Register the experiment folder with a `.mod` descriptor whose `path=` points at that directory (see `experiment/` for the example descriptor if present).
3. In the Stellaris launcher, enable **SD Static Portrait Test** (experiment name).
4. Start the game → create empire → **Mammalian** → select Piglet / Oakley / Angus.

Do **not** modify the vanilla Stellaris installation.

---

## Adding a new dog today (manual)

Until intake tooling exists, developers may still prepare assets by hand using the pipeline in [docs/portrait-workflow.md](docs/portrait-workflow.md). You do **not** need to invent numbers yourself once Phase 3.1 exists — see below.

`ImgHERE/` is the intake folder for finished portraits (and future candidate drops). Raw reference photos that are not finished portraits should not be treated as intake.

---

## Future user workflow (target)

**Phase 3.1 intake (designed, not built):** Drop a dog image into `ImgHERE` → enter the dog's name when prompted → the tool handles naming and numbering (`dog##_<name>_stellaris.png`) and prepares `assets/source/`.

**Later (full importer):** DDS generation, Stellaris registration, then launch Stellaris and test.

Details: [docs/development-roadmap.md](docs/development-roadmap.md) Phase 3.1, [docs/portrait-workflow.md](docs/portrait-workflow.md).

---

## Development

Collaboration process (Repomix / ChatGPT / Cursor): [docs/ai-development-workflow.md](docs/ai-development-workflow.md).
