# Stellar Dogos

Stellaris **4.4.x** mod that adds real-world dogs as selectable **Mammalian** species portraits.

Current in-game dogs: **Piglet**, **Oakley**, **Angus**.

---

## Status

| Item | State |
|------|--------|
| Species creation portraits | Working (static `texturefile` path confirmed on Pegasus **v4.4.6**) |
| Phase 3.1 portrait intake | Implemented (`tools/portrait-intake.ps1`) |
| Phase 4 DDS generation | Implemented (`tools/portrait-dds.ps1`) |
| Phase 5 Stellaris registration | Not implemented |
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

## Adding a Dog Portrait

1. Place the new dog image into `ImgHERE/`.
2. Open PowerShell in the Stellar Dogos repository.
3. Run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\portrait-intake.ps1
```

4. The tool will detect the new image and ask:

```text
What is this dog's name?
```

5. Enter the dog's name.

6. The tool automatically:

- assigns the next dog number
- creates the canonical filename
- prepares the portrait source PNG
- copies the prepared source to `assets/source/`
- removes the temporary input image after successful processing

7. The tool stops.

### DDS generation (Phase 4)

After intake, convert the canonical source PNG to a game DDS:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\portrait-dds.ps1 -Source assets\source\dog05_bruce_stellaris.png
```

This writes `sd_dog_<name>.dds` under the experiment portrait models folder. It does **not** register the portrait in Stellaris.

Stellaris registration is handled by a later stage of the project (Phase 5).

---

## Development

Collaboration process (Repomix / ChatGPT / Cursor): [docs/ai-development-workflow.md](docs/ai-development-workflow.md).
