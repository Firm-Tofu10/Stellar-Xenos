# Stellar Xeno — Steam Workshop Release Notes

This document describes how to publish the **game mod package** only.

## Package root

```text
mod/stellar_dogos/
```

That folder is the Stellaris mod. Do **not** upload the full Git repository (`tools/`, `ImgHERE/`, `assets/source/`, docs, Repomix, etc.).

## Package contents (required for Stellaris)

| Path | Role |
|------|------|
| `descriptor.mod` | Mod metadata (`name`, `tags`, `supported_version`, `picture`) — **no** developer absolute `path=` |
| `thumbnail.png` | Workshop/launcher thumbnail (`picture="thumbnail.png"`) |
| `gfx/portraits/portraits/00_sd_static_test_portraits.txt` | Portrait definitions |
| `gfx/models/portraits/sd_static_test/*.dds` | Portrait textures |
| `common/portrait_sets/00_sd_static_test_portrait_sets.txt` | Portrait sets |
| `common/portrait_categories/zzz_sd_static_test_portrait_categories.txt` | Category exposure |

Optional (not required by the game engine, safe to ship):

- `README.md` — player/author notes  
- `workshop_description.txt` — paste-ready Steam description  

## Workshop ID

Do **not** invent `remote_file_id`.

Steam/Paradox Launcher assigns the Workshop ID on **first successful upload** and writes `remote_file_id="…"` into the descriptor afterward. Leave it unset until then.

## Local launcher descriptor (outside the package)

For local play/upload, the Paradox Launcher uses a **separate** `.mod` file under:

`Documents/Paradox Interactive/Stellaris/mod/`

That external file is allowed to contain a `path=` to your copy of `mod/stellar_dogos/`.

The **package** `descriptor.mod` must remain path-free for Workshop distribution.

Example external launcher file (adjust the path to your machine):

```text
name="Stellar Xeno"
path="C:/Users/YOU/Documents/GitHub/Stellar Dogos/mod/stellar_dogos"
supported_version="v4.4.*"
tags={
	"Graphics"
	"Species"
}
picture="thumbnail.png"
```

See also: `stellar_xeno.mod.example` at the repository root (template only).

## Human publish checklist

1. Confirm `mod/stellar_dogos/` validates (all DDS present; no absolute paths).
2. Copy or point the launcher at this folder (external `.mod` with `path=`).
3. Enable **Stellar Xeno** in the Stellaris launcher.
4. **In-game smoke test** (required before public release):
   - Mammalian → Piglet / Oakley / Angus  
   - Avian → Sparrow or Zaldrin  
   - Reptilian → Lemon  
   - Fungoid → Blitz  
5. In the launcher: **Upload Mod** → Steam Workshop.
6. Leave Mod ID blank on first upload.
7. Paste text from `workshop_description.txt` into the Workshop description.
8. Set visibility to **Public** when ready.
9. After upload, confirm `remote_file_id` appeared (launcher may update descriptors).

## Portrait Creator (not in Workshop)

Creating new portraits uses repository tooling (`tools/portrait-pipeline.ps1`). That workflow is **not** inside the Workshop package.

Repo: https://github.com/Firm-Tofu10/Stellar-Dogos
