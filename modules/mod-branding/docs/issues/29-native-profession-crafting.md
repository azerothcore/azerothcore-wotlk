# #29 — Native profession crafting for Branded items (§8.6.1, client-coupled)

**Status:** implemented (server SQL + single-source tool + docs); client MPQ is a manual build step ·
**Deps:** #27 (output items, resources, `branding_recipe` mirror) · **Parallel-safe:** partially (client work isolated) · **Size:** L
**Companion:** #27 (server-side content/bind/upgrade half)

> **Implementation note.** All recipes are defined once in `tools/branding-craft`
> (`src/branding_craft/catalog.py`), which generates the server `spell_dbc` / `skilllineability_dbc` /
> `item_template` rows (`modules/mod-branding/data/sql/db-world/2026_06_22_00_native_craft.sql`) and the
> client `Spell.dbc` / `SkillLineAbility.dbc` patch CSVs, with `branding-craft validate` guarding the
> reagent lockstep in CI. Correction to the scope below: AzerothCore's DBC-override tables are
> **`spell_dbc`** and **`skilllineability_dbc`** (`DBCStores.cpp` `LoadFromDB`), not a
> `skill_line_ability` table. The only step not reproducible in-repo is merging the CSVs into the
> binary client DBCs + packing the MPQ (needs an extracted 3.3.5a client) — documented in the tool
> README.

## Context
Decision (2026-06-22): the **initial craft** of a Branded item is done by WoW's *native* crafting engine
and the recipe appears in the real Leatherworking/Blacksmithing window — not the custom `.branding`
gossip. (The custom path is retained only for the *branding upgrade* sink, #27/§8.6.1.) Native crafting
means new craft **spells**, which is a **client-side `Spell.dbc` deliverable** shipped in the module MPQ
patch — a heavier, client-coupled workstream than #27's server data.

## Scope
1. **Craft spells** — one `SPELL_EFFECT_CREATE_ITEM` spell per Branded recipe, with `Reagent`/
   `ReagentCount` = the §16 resources (tradeable Material + BoA Fragment) and `EffectItemType` = the #27
   Branded output. Added to **`Spell.dbc`** (client copy in the MPQ patch) and to the server (`spell_dbc`
   world table / server DBC) so client and core agree. Reagent counts **must equal** the matching
   `branding_recipe` row (#27) — that table is the server-side mirror / drift guard.
2. **Skill-line wiring** — `skill_line_ability` (`pending_db_world`): map each craft spell to its
   profession skill line (Leatherworking 165, Blacksmithing 164, Tailoring 197, …) with
   `req_skill_value` and trivial-rank coloring.
3. **Recipe pattern items** — `item_template` (`pending_db_world`) per recipe: `spellid_1` = the craft
   spell, `spelltrigger_1 = 6` (learn), **`bonding = 1` (BoP)** so recipes are **not tradable** (owner
   decision). Sourced as drops/rewards (raid/dungeon) — placement is content (coordinate with #13).
4. **MPQ packaging** — extend the module's client deliverable (alongside `client-addon`) to ship the
   patched `Spell.dbc` (+ any custom icon BLPs if not reusing existing `displayid`s). Document the
   build/extract step in `tools/` and README.

## Risks / notes
- **Client/server DBC must stay in lockstep** — a craft spell the client lacks is uncastable; one the
  server lacks is rejected. Version the MPQ with the server build.
- DBC editing is the real cost here. If the client-patch lift is undesirable, the fallback is #27's
  custom `.branding craft` entry point alone (server-only, no native window) — keep that path working as
  the degradation mode.
- Reagents live in the spell, so the native engine consumes them; do **not** double-consume in any
  adapter. `branding_recipe`/`ResolveCraft` here are validation/mirror only for the initial craft.

## Acceptance
- A profession recipe pattern is learnable; the recipe shows in the native profession window; crafting
  consumes the exact Material/Fragment reagents and produces the BoA Branded item; the craft is gated by
  the profession skill. Reagent counts match the `branding_recipe` mirror (#27). MPQ patch documented
  and reproducible.

## Touch points
`Spell.dbc` (client MPQ + server), `skill_line_ability` + pattern `item_template`
(`pending_db_world`), `tools/` (MPQ build), `client-addon`/README. Deps #27 (outputs, resources,
mirror); coordinate #13 (pattern drop placement), #05 (upgrade path stays separate).
