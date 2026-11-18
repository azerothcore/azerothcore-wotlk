# Templates and loot

## Sniffed template columns

- Columns the client receives in a query response (WDB) or object update are sniffed and hold observed values, e.g.
  from query responses `gameobject_template` `type` and `Data*`, most `quest_template` columns (`RewardNextQuest`),
  `creature_template` `HealthModifier`; from object updates `creature_template` `faction`, `unit_class`, `unit_flags`,
  `unit_flags2`.
- Never edit one to work around wrong behaviour; fix that in SAI, conditions, `quest_template_addon` or core. E.g.
  despawn a used gameobject with `FORCE_DESPAWN`, not a `Data*` change; unit flags: `retail-evidence.md`.
- Only own or upstream sniff evidence that the value itself is wrong justifies a template fix (never another core's
  unsniffed value), stamped with `VerifiedBuild`, never a runtime override instead (e.g. SAI On Respawn Set Faction).
- Server-side columns are exempt, e.g. `AIName`, `ScriptName`, `flags_extra`, gold, `*_template_addon` money.

## creature_template_model

- Rows were generated from the old `modelid1`-`modelid4` columns, and that migration copied
  `creature_template.VerifiedBuild` onto every `Idx`: equal probabilities are that import's default, not a
  randomization claim.
- Judge a stamp by its build, not its `Idx`: a legacy build on the extra rows is migration noise, while later sniff
  passes stamp `Idx` >= 1 legitimately.
- Authority is the creature query response's per-index `Probability`, which Classic and retail sniffs carry and 3.3.5
  clients omit.
- Suppress a model by setting its `Probability` to 0 and keeping the row, never by deleting it. Keep a creature's only
  row at 1: the loader reads a zero total as equal chance and resets every row to 1.0.

## creature_immunities

- Negative ids are curated shared sets: reference them via `creature_template.CreatureImmunitiesId`, never edit them
  or allocate new ones.
- Positive ids are single-creature sets: reuse one only on an exact match. To extend a creature's immunities, insert a
  superset under a new id and point its `CreatureImmunitiesId` at it.

## Loot

- A creature whose incidental drops (greens, scrolls, bags, recipes, cards) show it drops world loot gets one or two
  reference rows to level-matched 'World Loot Level <N>' `reference_loot_template` entries instead of those per-item
  rows. Creature-specific items and trade goods (food, cloth) keep their own rows.
- A 'World Loot Level' entry is series + offset + level. Series: 1000000 Vanilla, 1100000 TBC, 1200000 WotLK; where
  they overlap (levels 58-63, 68-72) the creature's expansion decides (e.g. Hellfire level-60 mobs: 1100060). Offset:
  +0 base, +100 adds scrolls and potions, +200 elite, +300 elite with scrolls and potions.
- A pool several rows or groups share (e.g. several Vanilla Greens level-range references) becomes one new
  `reference_loot_template` entry they all point at, not repeated members.
