# SD Static Portrait Test (experiment)

Working proof-of-concept for **Stellar Dogos** static species portraits on Stellaris **Pegasus v4.4.6**.

**CONFIRMED:** `texturefile` static portraits appear in Mammalian species creation.

Current portraits: `sd_dog_piglet` (Piglet), `sd_dog_02` (Oakley), `sd_dog_angus` (Angus).

Project docs (authoritative):

- `../../PROJECT_PLAN.md`
- `../../docs/portrait-workflow.md`
- `../../docs/development-roadmap.md`
- `../../docs/portrait-testing.md`

## Enable in the launcher

1. Ensure `Documents\Paradox Interactive\Stellaris\mod\` exists.
2. Point a `.mod` descriptor `path=` at this folder (forward slashes).
3. Enable the mod in the Stellaris launcher.
4. Empire creation → **Mammalian** → select a dog portrait.

## Important

- Do not modify the vanilla Stellaris installation.
- Piglet and Oakley are protected regression fixtures unless a task explicitly changes them.
- Full UI compatibility beyond species creation is **not** fully verified yet.

## Revert

Disable/delete the launcher `.mod` descriptor and/or this folder. No vanilla files need restoring.
