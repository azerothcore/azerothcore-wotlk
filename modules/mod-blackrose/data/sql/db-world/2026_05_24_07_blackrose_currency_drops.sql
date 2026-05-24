-- ============================================================================
-- Black Rose: spread Black Petals + Black Miasma currency across instances
--
-- These two items are the *currency mats* players spend at the Black Rose
-- vendor to buy socketable gems - they are NOT the gems themselves. The
-- third currency, Black Thorns, stays a quest/mount-line drop and is not
-- seeded onto generic boss loot tables.
--
-- Targets:
--   * Every 5-man dungeon end boss whose minlevel >= 20  (15% each item)
--   * Every raid boss on a known raid map ID            (25% each item)
--
-- "End boss" for 5-mans is determined by instance_encounters.lastEncounterDungeon > 0
-- which is the LFG-credit final boss for that instance. This avoids dropping on
-- bosses 1..N-1 of a 5-man (we want a real reason to push to the final pull).
--
-- "Raid boss" is determined by joining the boss's home map (creature.map) against
-- a hardcoded raid map ID list - DungeonEncounter.dbc and Map.dbc are not loaded
-- into acore_world on this server (they live client-side), so we can't use them
-- for this filter. The raid map list covers every retail raid in 3.3.5a content.
--
-- Drops are independent rolls (GroupId = 0), one per item, so a boss can drop
-- both, one, or neither. Reference = 0 so they are direct item drops, not
-- references into reference_loot_template. INSERT IGNORE makes re-runs safe.
--
-- Item IDs (from mod-blackrose item_template, class = 12 quest/currency):
--   900200 = Black Miasma
--   900201 = Black Petals
-- ============================================================================

SET @ITEM_MIASMA := 900200;
SET @ITEM_PETALS := 900201;

-- Raid maps (3.3.5a). Onyxia, MC, BWL, AQ20/40, Naxx, Karazhan, Hyjal,
-- Magtheridon, SSC, TK Eye, Black Temple, Gruul, ZA, Sunwell, Ulduar,
-- OS, EoE, VoA, ICC, ToC raid, RS, ZG.
SET @RAID_MAPS := '249,309,409,469,509,531,532,533,534,544,548,550,564,565,568,580,603,615,616,624,631,724';

-- ----------------------------------------------------------------------------
-- 1. 5-man dungeon end bosses, level 20+ -> 15% each currency
-- ----------------------------------------------------------------------------
INSERT IGNORE INTO `creature_loot_template`
    (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`,
     `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT DISTINCT
       ie.creditEntry, @ITEM_MIASMA, 0, 15.0, 0,
       1, 0, 1, 1, 'Black Miasma - Black Rose currency (5-man end boss)'
  FROM instance_encounters ie
  JOIN creature_template ct ON ct.entry = ie.creditEntry
 WHERE ie.creditType = 0
   AND ie.lastEncounterDungeon > 0
   AND ct.minlevel >= 20
   AND ie.creditEntry NOT IN (
       SELECT DISTINCT id1 FROM creature
        WHERE FIND_IN_SET(map, @RAID_MAPS) > 0);

INSERT IGNORE INTO `creature_loot_template`
    (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`,
     `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT DISTINCT
       ie.creditEntry, @ITEM_PETALS, 0, 15.0, 0,
       1, 0, 1, 1, 'Black Petals - Black Rose currency (5-man end boss)'
  FROM instance_encounters ie
  JOIN creature_template ct ON ct.entry = ie.creditEntry
 WHERE ie.creditType = 0
   AND ie.lastEncounterDungeon > 0
   AND ct.minlevel >= 20
   AND ie.creditEntry NOT IN (
       SELECT DISTINCT id1 FROM creature
        WHERE FIND_IN_SET(map, @RAID_MAPS) > 0);

-- ----------------------------------------------------------------------------
-- 2. Raid bosses on raid maps -> 25% each currency
-- ----------------------------------------------------------------------------
INSERT IGNORE INTO `creature_loot_template`
    (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`,
     `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT DISTINCT
       ie.creditEntry, @ITEM_MIASMA, 0, 25.0, 0,
       1, 0, 1, 1, 'Black Miasma - Black Rose currency (raid boss)'
  FROM instance_encounters ie
 WHERE ie.creditType = 0
   AND ie.creditEntry IN (
       SELECT DISTINCT id1 FROM creature
        WHERE FIND_IN_SET(map, @RAID_MAPS) > 0);

INSERT IGNORE INTO `creature_loot_template`
    (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`,
     `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT DISTINCT
       ie.creditEntry, @ITEM_PETALS, 0, 25.0, 0,
       1, 0, 1, 1, 'Black Petals - Black Rose currency (raid boss)'
  FROM instance_encounters ie
 WHERE ie.creditType = 0
   AND ie.creditEntry IN (
       SELECT DISTINCT id1 FROM creature
        WHERE FIND_IN_SET(map, @RAID_MAPS) > 0);
