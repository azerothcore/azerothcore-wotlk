# #02 — Active brand + proc loadout selection (§7.9)

**Status:** open · **Deps:** none (pairs with #01) · **Parallel-safe:** yes · **Size:** M

## Context
Players need to *choose* their active brand and proc archetype (§7.9 `BrandLoadout`,
`IsLoadoutValid`). This is the root prerequisite for the effect-application stack (#03→#04/#05) and
for activity capture (which currently hardcodes `BrandId::Fire` in the demo kill hook).

## Scope
- Pure: reuse `core/effects/ItemBrand.h` `BrandLoadout` + `IsLoadoutValid` (already tested). Add a
  per-character loadout type + validation wiring only if new rules surface.
- Persistence: `character_brand_loadout` table (guid, active_brand, proc_archetype) — SQL update in
  `pending_db_characters` (DELETE-before-INSERT not needed for CREATE; InnoDB; codestyle-sql).
- Adapter: `LoadoutMgr` keyed by `ObjectGuid` — load on login, save on change; `SetActiveBrand`,
  `SetArchetype` validated via `IsLoadoutValid` against the account's knowledge + char proficiency.
- Command/gossip: `.branding setbrand <brand>` / `.branding setproc <n>` (validate + persist).
- Replace the hardcoded brand in `ProficiencyScripts` demo capture with the player's active brand.

## Acceptance
- Standard DoD. `IsLoadoutValid` rejections surface as command errors.
- Switching brand persists across relog; invalid archetype (above proficiency) is refused.

## Touch points
`src/LoadoutMgr.*` (new), `src/BrandingCommandScript.cpp`, `ProficiencyScripts.cpp`,
new `pending_db_characters` SQL.
