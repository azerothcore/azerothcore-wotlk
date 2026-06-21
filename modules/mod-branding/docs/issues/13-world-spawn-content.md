# #13 — World-spawned discovery content (§8.4)

**Status:** open · **Deps:** discovery adapter exists · **Parallel-safe:** yes (data, not code) · **Size:** M (volume)

## Context
§8.4 wants profession-flavoured discoverables placed in the world (e.g. *rusted dwarven hammerhead*
BS 20–30, *abandoned herbal journals* Alchemy 35–45, *arcane residue* Enchanting 50+). On interact
they grant recipes / profession XP / reputation / hidden quests. The tier ruleset
(`TierForZoneLevel`, §8.3) is the structured contract content is generated against.

## Scope
- Data (`pending_db_world`): gameobject spawns + a `branding_discovery_object` mapping
  (object → tier, reward type, payload). Author against the §8.3 tier table (Common 1–20 / Uncommon
  20–40 / Rare 40–60 / Epic 60+).
- Thin adapter: a `GameObjectScript` interact hook → resolve reward via core + `RewardDelivery`;
  mark discovered (own dedupe or reuse the §8.2 first-visit semantics).
- This is **bulk LLM-authorable**: "generate N <profession> discoveries for zones X–Y, Tier T".

## Acceptance
- Standard DoD (incl. codestyle-sql). A placed object, on first interact, grants its tier-appropriate
  reward once and nothing on re-interact.

## Touch points
Mostly `pending_db_world` SQL/data + a small `GameObjectScript`. Independent; high-volume content.
