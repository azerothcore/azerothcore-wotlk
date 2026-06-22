# branding-craft

Single source of truth for **mod-branding native profession crafting** (issues
[#27](../../docs/issues/27-branded-item-recipes.md) server content +
[#29](../../docs/issues/29-native-profession-crafting.md) client-coupled craft spells).

Every Branded recipe is defined **once**, in
[`src/branding_craft/catalog.py`](src/branding_craft/catalog.py). From that catalog the tool
generates both halves of the craft surface so they cannot drift:

| Artifact | Side | Consumed by |
|---|---|---|
| `spell_dbc` rows | server | AzerothCore `DBCStores.cpp` `LoadFromDB` injects them into the Spell DBC store at load |
| `skilllineability_dbc` rows | server | same, for `SkillLineAbility.dbc` (maps the spell into a profession) |
| `item_template` rows | server | resources (#27), Branded outputs (#27), BoP recipe patterns (#29) |
| `branding_recipe` rows | server | the `#09` `EconomyMgr`/`RecipeBook` loader (the **mirror** / drift guard) |
| `Spell.dbc` patch CSV | client | merged into the extracted client DBC, repacked into the module MPQ |
| `SkillLineAbility.dbc` patch CSV | client | same |

> **Lockstep.** The reagent counts in the craft spell (`spell_dbc` + client `Spell.dbc`) and in the
> `branding_recipe` mirror come from the *same* catalog field. `branding-craft validate` (run in CI)
> fails if they ever disagree — exactly the "client/server DBC must stay in lockstep" risk in #29.

## Usage

```bash
cd modules/mod-branding/tools/branding-craft
uv run branding-craft validate     # consistency + branding_recipe lockstep (exit 1 on drift)
uv run branding-craft world-sql    # item_template + spell_dbc + skilllineability_dbc (module db-world)
uv run branding-craft recipe-sql   # the branding_recipe mirror repoint (the #09 core pending rev)
uv run branding-craft spell-csv    # client Spell.dbc patch rows (CSV, for manual DBC tools)
uv run branding-craft skill-csv    # client SkillLineAbility.dbc patch rows (CSV)
uv run branding-craft build-dbc --spell-in base/Spell.dbc --skill-in base/SkillLineAbility.dbc \
                                --out-dir out/   # merge craft rows into extracted DBCs (binary)
```

Each emit command writes to stdout, or to a file with `--out FILE`.

### Where the generated SQL lives

| Command | Committed file | Why |
|---|---|---|
| `world-sql` | `modules/mod-branding/data/sql/db-world/<date>_native_craft.sql` | module-owned content (auto-imported by AzerothCore); `item_template` `DELETE` is fine here — the core SQL linter only scans `data/sql/{updates,base,archive}` |
| `recipe-sql` | the `branding_recipe` block of the #09 core pending rev (`data/sql/updates/pending_db_world/`) | the table is created/owned there; keeping it single-homed avoids two conflicting seeds |

Dev:

```bash
uv run pytest        # tests
uv run ruff check .  # lint
```

## Adding / changing a recipe

1. Edit `CATALOG` in [`src/branding_craft/catalog.py`](src/branding_craft/catalog.py) (stay inside the
   §16.4 reserved bands — the validator enforces this).
2. `uv run branding-craft validate` — must pass.
3. Regenerate the server SQL:
   ```bash
   uv run branding-craft world-sql  --out ../../data/sql/db-world/2026_06_22_00_native_craft.sql
   uv run branding-craft recipe-sql                 # then paste into the #09 core pending rev's
                                                    # branding_recipe block (single home)
   # core pending files (the recipe rev) must pass: python <repo>/apps/codestyle/codestyle-sql.py
   ```
4. Regenerate the client DBC patch and rebuild the MPQ (below).

## Building the client MPQ patch (the #29 client deliverable)

`build-dbc` merges the craft rows directly into an **extracted base DBC** and writes ready-to-pack
`Spell.dbc` / `SkillLineAbility.dbc` binaries — only the final MPQ pack needs an external tool (MPQ
*writing* is out of scope for pure Python).

```bash
# 1. Extract the client's CURRENT Spell.dbc + SkillLineAbility.dbc (see caveat below) to ./base/
#    e.g. with MPQEditor, or mpyq:  python -c "from mpyq import MPQArchive; ...read_file(...)"
# 2. Patch them:
uv run branding-craft build-dbc \
    --spell-in base/Spell.dbc --skill-in base/SkillLineAbility.dbc --out-dir out/
# 3. Pack out/Spell.dbc + out/SkillLineAbility.dbc into a patch MPQ under DBFilesClient\, e.g.
#    a free patch-<letter>.MPQ slot that loads AFTER all others, dropped in the client's Data/.
#    Ship it alongside the client-addon. Version it with the server build.
```

> ⚠️ **DBC is whole-file, not per-row, across MPQs.** When the client loads, the *highest-precedence*
> `Spell.dbc` wins outright — rows are **not** merged across archives. So you must build on top of the
> **effective** DBC your client actually uses (extract it, patch, then ship at higher precedence),
> otherwise your patch silently drops every spell that lived in a higher base patch. On a stock 3.3.5a
> client the effective file is the one in the locale/`patch-?` MPQs; on a custom client (e.g.
> Ascension) it is whichever custom patch carries the largest Spell.dbc.

### Verified against a real client (Ascension 3.3.5a base, 2026-06-22)

Probing the client at `…/resources/client/Data` confirmed the design holds:

- **Spell.dbc schema is stock 3.3.5a** — 234 fields / 936-byte records — so the server `spell_dbc`
  rows and this patcher use the correct layout (`build-dbc` asserts this and refuses a mismatched DBC).
- **The reserved spell band `1900000–1900099` and SLA band `1900100–1900199` are collision-free** in
  the client's 208 k spells / 39 k abilities.
- **Display ids verified present** in `ItemDisplayInfo.dbc`: `6884`, `41111`, `48723`, `48729`,
  `48733`, and the pattern icon `1387`. (`2000`, the original placeholder, was absent — retargeted.)
- `build-dbc` on the extracted bases produced valid binaries: Spell.dbc 208 526 → 208 529 records,
  SkillLineAbility.dbc 39 719 → 39 722, originals preserved, our rows + spell names appended.

[WoWDBDefs]: https://github.com/wowdev/WoWDBDefs

### Degradation mode

If the client patch is undesirable, the native window simply won't show the recipes — but the
server-only `.branding craft <id>` path (#27/§8.6.1, `EconomyMgr`) keeps working as the documented
fallback. Keep that path functional whenever this catalog changes.
