# SD Static Portrait Test (experiment)

Temporary one-portrait mod to verify whether `texturefile` static species portraits still appear in Stellaris **4.4.6**.

## Enable in the launcher

1. Ensure this folder exists:
   `Documents\Paradox Interactive\Stellaris\mod\`
2. Copy `sd_static_portrait_test.mod.example` from the repo `experiment/` folder to:
   `Documents\Paradox Interactive\Stellaris\mod\sd_static_portrait_test.mod`
3. Confirm the `path=` line points at this experiment folder (forward slashes).
4. In the Stellaris launcher, enable **SD Static Portrait Test**.
5. Start the game → create empire → open species / portraits → **Mammalian**.

## What success looks like

A bright **magenta** square with **cyan X** stripes among Mammalian portraits.

## Revert

Disable/delete the `.mod` descriptor and/or this experiment folder. No vanilla files are modified.
