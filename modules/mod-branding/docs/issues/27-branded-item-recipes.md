# #27 — Branded-item content, economy bind & upgrade tuning (§8.1/§8.6/§16.3)

**Status:** open · **Deps:** #09 (`EconomyMgr`/`RecipeBook` loader, shipped) · **Parallel-safe:** yes (data + conf) · **Size:** M
**Companion:** #28 (native profession crafting — the client-coupled half of the initial-craft surface)

## Context
#09 built the crafting *machinery* — `EconomyMgr` queries
`SELECT id, materials, fragments, output_item, char_xp FROM branding_recipe`, loads rows into the pure
`RecipeBook`, and `ResolveCraft` consumes exact inputs → output item + char XP. Missing is the **data**:
no SQL creates/seeds `branding_recipe`, the resources are placeholder cloth (`MaterialItemId = 2589`
Linen, `FragmentItemId = 2592` Wool), and there are no actual **Branded items** to produce.

This issue is the **server-side, no-client-patch half** — item content, the economy resources, the
`branding_recipe` mirror, the bind model, and the branding-upgrade cost curve. The *initial-craft UX*
(recipes inside the real Leatherworking/Blacksmithing window) is client-coupled and lives in **#28**.

## Decisions (locked with owner, 2026-06-22)
- **Base power = modest heroic-dungeon level.** Branded outputs clone the *model/icon/slot* of WotLK
  heroic-dungeon items but carry **modest stats**; power comes from branding procs, never the base item
  (§1 anti-obsolescence). No raid-BiS stat clones.
- **Bind = hybrid** (§16.3 amended). **Materials** tradeable (BoE, the surviving market). **Fragments**
  and **Branded items** **account-bound (BoA)** / account-wide. **Recipe patterns** BoP (see #28).
- **Two craft surfaces** (§8.6.1): *initial craft* → native profession (#28); *branding upgrade* →
  custom `.branding` + `ResolveCraft` (this issue). `branding_recipe` is the **server-side mirror** of
  the native reagent defs, so counts can't drift from `Spell.dbc`.
- **Upgrade cost curve.** A single Brand Rank is cheap/fast; a **full max-out = focused multi-week guild
  effort** (vanilla-legendary feel). Tuned via #05's `ApplyItemUpgrade` per-rank cost +
  `ItemMaxCumulativeCost`.

## Scope (server data + conf only)
1. **Resource items** (`pending_db_world`, `item_template`) — purpose-built **Material** (`bonding=2`
   BoE, common, dungeon-sourced) and **Fragment** (`bonding=5` BoA, premium, raid/invasion-sourced),
   high `stackable`. §16.1 canonical names verbatim. Reuse a fitting `displayid` for icons.
2. **Branded output items** (`pending_db_world`, `item_template`) — starter set across §8.3 tiers,
   `bonding=5` (BoA), `displayid` cloned from heroic gear, **modest** `stat_type/value` + `ItemLevel`,
   proc carried in `spellid_N`/`spelltrigger_N` (the surface #05 modulates). `RequiredSkill` set to the
   matching profession (e.g. leather → Leatherworking) so the gate holds even before #28's window UX.
3. **`branding_recipe` table** — DDL + seed in `pending_db_world`; columns match the #09 query exactly
   (`id` PK, `materials`, `fragments`, `output_item`, `char_xp`). InnoDB, DELETE-before-INSERT, 4-space,
   trailing newline. One row per Branded output (input cost scaling with tier). Zero `output_item` rows
   are dropped by `RecipeBook::Add`. These mirror #28's native reagent defs.
4. **Config** — repoint `Branding.Economy.MaterialItemId` / `FragmentItemId` (and the mirrored
   `Branding.Event.RewardItemId`, §16.3) to the new entries in `conf/mod_branding.conf.dist`; fix the
   Linen/Wool comments.
5. **Upgrade curve tuning** — set the #05 per-rank cost so single-rank is cheap and max-out is a
   multi-week guild grind. (Curve numbers; coordinate with #05.)

## Item-entry band — decided
Reserved band `190000–190099` (`ARCHITECTURE.md` §16.4): resources `190000–190001`, Branded outputs
`190010+`, recipe patterns `190050+`. Map each to a `Branding.<Sub>.*ItemId` config key.

## Acceptance
- Standard DoD incl. `codestyle-sql.py`. `branding_recipe` loads without the "output_item is 0" warning;
  `RecipeCount()` ≥ seeded count after `LoadRecipes()`.
- Manual verify (`Branding.Economy.Enable = 1`): the custom craft entry point consumes exact
  Material/Fragment inputs, delivers the BoA Branded output, grants char XP; under-resourced attempt
  refused without consuming. Materials trade; Fragments + Branded items are BoA. Single Brand-Rank
  upgrade is cheap; max-out demonstrably long.

## Touch points
`data/sql/updates/pending_db_world/rev_*.sql` (new), `conf/mod_branding.conf.dist`,
`docs/ARCHITECTURE.md` §16 (entry band), #05 upgrade-curve constants. No new C++ for craft resolution.
Coordinate: #05 (upgrade sink), #06 (vault stores BoA Fragments), #09 (loader), **#28** (native craft).
