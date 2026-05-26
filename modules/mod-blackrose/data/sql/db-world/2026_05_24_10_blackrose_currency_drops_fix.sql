-- ============================================================================
-- Black Rose: repair and rebalance instance currency drops.
--
-- This file intentionally repeats the corrected logic from
-- 2026_05_24_07_blackrose_currency_drops.sql because existing databases may
-- have already recorded that earlier update as applied.
--
-- Dungeons choose exactly one Black Rose currency on final bosses. Raids drop
-- all three currencies from every represented creature boss.
-- ============================================================================

SET @ITEM_MIASMA := 900200;
SET @ITEM_PETALS := 900201;
SET @ITEM_THORNS := 900202;
SET @DUNGEON_GROUP := 127;
SET @RAID_FINAL_GROUP := 126;
SET @RAID_BOSS_COUNT := 1;
SET @RAID_FINAL_BONUS_COUNT := 2;

DELETE FROM `creature_loot_template`
 WHERE `Item` IN (@ITEM_MIASMA, @ITEM_PETALS, @ITEM_THORNS)
    OR `Reference` IN (900800, 900801, 900802, 900803, 900804, 900805);

DELETE FROM `reference_loot_template`
 WHERE `Entry` IN (900800, 900801, 900802, 900803, 900804, 900805);

-- ----------------------------------------------------------------------------
-- Dungeon final bosses: one equal-chance currency group.
-- ----------------------------------------------------------------------------
DELETE FROM `creature_loot_template` WHERE `Entry` = 0 AND `Item` = 0;
INSERT INTO `creature_loot_template`
    (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`,
     `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT `dungeon`.`Entry`,
       `currency`.`Item`,
       0,
       0,
       0,
       1,
       @DUNGEON_GROUP,
       1,
       1,
       `currency`.`Name`
  FROM (
       SELECT DISTINCT `raw`.`LootId` AS `Entry`
         FROM (
              SELECT `ct`.`lootid` AS `LootId`
                FROM `instance_encounters` `ie`
                JOIN `creature_template` `ct`
                  ON `ct`.`entry` = `ie`.`creditEntry`
               WHERE `ie`.`creditType` = 0
                 AND `ie`.`lastEncounterDungeon` > 0
                 AND `ct`.`lootid` <> 0
                 AND NOT EXISTS (
                     SELECT 1 FROM `creature` `c`
                      WHERE `c`.`id1` = `ie`.`creditEntry`
                        AND `c`.`map` IN
                            (249, 309, 409, 469, 509, 531, 532, 533, 534,
                             544, 548, 550, 564, 565, 568, 580, 603, 615,
                             616, 624, 631, 649, 724))
              UNION ALL
              SELECT `d1`.`lootid`
                FROM `instance_encounters` `ie`
                JOIN `creature_template` `ct`
                  ON `ct`.`entry` = `ie`.`creditEntry`
                JOIN `creature_template` `d1`
                  ON `d1`.`entry` = `ct`.`difficulty_entry_1`
               WHERE `ie`.`creditType` = 0
                 AND `ie`.`lastEncounterDungeon` > 0
                 AND `d1`.`lootid` <> 0
                 AND NOT EXISTS (
                     SELECT 1 FROM `creature` `c`
                      WHERE `c`.`id1` = `ie`.`creditEntry`
                        AND `c`.`map` IN
                            (249, 309, 409, 469, 509, 531, 532, 533, 534,
                             544, 548, 550, 564, 565, 568, 580, 603, 615,
                             616, 624, 631, 649, 724))
              UNION ALL
              SELECT `d2`.`lootid`
                FROM `instance_encounters` `ie`
                JOIN `creature_template` `ct`
                  ON `ct`.`entry` = `ie`.`creditEntry`
                JOIN `creature_template` `d2`
                  ON `d2`.`entry` = `ct`.`difficulty_entry_2`
               WHERE `ie`.`creditType` = 0
                 AND `ie`.`lastEncounterDungeon` > 0
                 AND `d2`.`lootid` <> 0
                 AND NOT EXISTS (
                     SELECT 1 FROM `creature` `c`
                      WHERE `c`.`id1` = `ie`.`creditEntry`
                        AND `c`.`map` IN
                            (249, 309, 409, 469, 509, 531, 532, 533, 534,
                             544, 548, 550, 564, 565, 568, 580, 603, 615,
                             616, 624, 631, 649, 724))
              UNION ALL
              SELECT `d3`.`lootid`
                FROM `instance_encounters` `ie`
                JOIN `creature_template` `ct`
                  ON `ct`.`entry` = `ie`.`creditEntry`
                JOIN `creature_template` `d3`
                  ON `d3`.`entry` = `ct`.`difficulty_entry_3`
               WHERE `ie`.`creditType` = 0
                 AND `ie`.`lastEncounterDungeon` > 0
                 AND `d3`.`lootid` <> 0
                 AND NOT EXISTS (
                     SELECT 1 FROM `creature` `c`
                      WHERE `c`.`id1` = `ie`.`creditEntry`
                        AND `c`.`map` IN
                            (249, 309, 409, 469, 509, 531, 532, 533, 534,
                             544, 548, 550, 564, 565, 568, 580, 603, 615,
                             616, 624, 631, 649, 724))
              UNION ALL
              -- Trial of the Champion uses spell credit for The Black Knight.
              SELECT `ct`.`lootid`
                FROM `creature_template` `ct`
               WHERE `ct`.`entry` = 35451
                 AND `ct`.`lootid` <> 0
              UNION ALL
              SELECT `ct`.`lootid`
                FROM `creature_template` `ct`
               WHERE `ct`.`entry` = 35490
                 AND `ct`.`lootid` <> 0
              ) `raw`
       ) `dungeon`
 CROSS JOIN (
       SELECT @ITEM_MIASMA AS `Item`,
              'Black Miasma - Black Rose dungeon currency' AS `Name`
       UNION ALL
       SELECT @ITEM_PETALS,
              'Black Petals - Black Rose dungeon currency'
       UNION ALL
       SELECT @ITEM_THORNS,
              'Black Thorns - Black Rose dungeon currency'
       ) `currency`;

-- ----------------------------------------------------------------------------
-- Raid bosses: all currencies drop, final represented bosses drop more.
-- ----------------------------------------------------------------------------
DELETE FROM `creature_loot_template` WHERE `Entry` = 0 AND `Item` = 0;
INSERT INTO `creature_loot_template`
    (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`,
     `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT `raid`.`Entry`,
       `currency`.`Item`,
       0,
       100,
       0,
       1,
       0,
       @RAID_BOSS_COUNT,
       @RAID_BOSS_COUNT,
       `currency`.`Name`
  FROM (
       SELECT DISTINCT `raw`.`LootId` AS `Entry`
         FROM (
              SELECT `ct`.`lootid` AS `LootId`
                FROM `instance_encounters` `ie`
                JOIN `creature_template` `ct`
                  ON `ct`.`entry` = `ie`.`creditEntry`
               WHERE `ie`.`creditType` = 0
                 AND `ct`.`lootid` <> 0
                 AND EXISTS (
                     SELECT 1 FROM `creature` `c`
                      WHERE `c`.`id1` = `ie`.`creditEntry`
                        AND `c`.`map` IN
                            (249, 309, 409, 469, 509, 531, 532, 533, 534,
                             544, 548, 550, 564, 565, 568, 580, 603, 615,
                             616, 624, 631, 649, 724))
              UNION ALL
              SELECT `d1`.`lootid`
                FROM `instance_encounters` `ie`
                JOIN `creature_template` `ct`
                  ON `ct`.`entry` = `ie`.`creditEntry`
                JOIN `creature_template` `d1`
                  ON `d1`.`entry` = `ct`.`difficulty_entry_1`
               WHERE `ie`.`creditType` = 0
                 AND `d1`.`lootid` <> 0
                 AND EXISTS (
                     SELECT 1 FROM `creature` `c`
                      WHERE `c`.`id1` = `ie`.`creditEntry`
                        AND `c`.`map` IN
                            (249, 309, 409, 469, 509, 531, 532, 533, 534,
                             544, 548, 550, 564, 565, 568, 580, 603, 615,
                             616, 624, 631, 649, 724))
              UNION ALL
              SELECT `d2`.`lootid`
                FROM `instance_encounters` `ie`
                JOIN `creature_template` `ct`
                  ON `ct`.`entry` = `ie`.`creditEntry`
                JOIN `creature_template` `d2`
                  ON `d2`.`entry` = `ct`.`difficulty_entry_2`
               WHERE `ie`.`creditType` = 0
                 AND `d2`.`lootid` <> 0
                 AND EXISTS (
                     SELECT 1 FROM `creature` `c`
                      WHERE `c`.`id1` = `ie`.`creditEntry`
                        AND `c`.`map` IN
                            (249, 309, 409, 469, 509, 531, 532, 533, 534,
                             544, 548, 550, 564, 565, 568, 580, 603, 615,
                             616, 624, 631, 649, 724))
              UNION ALL
              SELECT `d3`.`lootid`
                FROM `instance_encounters` `ie`
                JOIN `creature_template` `ct`
                  ON `ct`.`entry` = `ie`.`creditEntry`
                JOIN `creature_template` `d3`
                  ON `d3`.`entry` = `ct`.`difficulty_entry_3`
               WHERE `ie`.`creditType` = 0
                 AND `d3`.`lootid` <> 0
                 AND EXISTS (
                     SELECT 1 FROM `creature` `c`
                      WHERE `c`.`id1` = `ie`.`creditEntry`
                        AND `c`.`map` IN
                            (249, 309, 409, 469, 509, 531, 532, 533, 534,
                             544, 548, 550, 564, 565, 568, 580, 603, 615,
                             616, 624, 631, 649, 724))
              ) `raw`
       ) `raid`
 CROSS JOIN (
       SELECT @ITEM_MIASMA AS `Item`,
              'Black Miasma - Black Rose raid currency' AS `Name`
       UNION ALL
       SELECT @ITEM_PETALS,
              'Black Petals - Black Rose raid currency'
       UNION ALL
       SELECT @ITEM_THORNS,
              'Black Thorns - Black Rose raid currency'
       ) `currency`;

DELETE FROM `creature_loot_template` WHERE `Entry` = 0 AND `Item` = 0;
INSERT INTO `creature_loot_template`
    (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`,
     `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT `raid`.`Entry`,
       `currency`.`Item`,
       0,
       100,
       0,
       1,
       @RAID_FINAL_GROUP,
       @RAID_FINAL_BONUS_COUNT,
       @RAID_FINAL_BONUS_COUNT,
       `currency`.`Name`
  FROM (
       SELECT DISTINCT `raw`.`LootId` AS `Entry`
         FROM (
              SELECT `ct`.`lootid` AS `LootId`
                FROM `instance_encounters` `ie`
                JOIN `creature_template` `ct`
                  ON `ct`.`entry` = `ie`.`creditEntry`
               WHERE `ie`.`creditType` = 0
                 AND `ie`.`lastEncounterDungeon` > 0
                 AND `ct`.`lootid` <> 0
                 AND EXISTS (
                     SELECT 1 FROM `creature` `c`
                      WHERE `c`.`id1` = `ie`.`creditEntry`
                        AND `c`.`map` IN
                            (249, 309, 409, 469, 509, 531, 532, 533, 534,
                             544, 548, 550, 564, 565, 568, 580, 603, 615,
                             616, 624, 631, 649, 724))
              UNION ALL
              SELECT `d1`.`lootid`
                FROM `instance_encounters` `ie`
                JOIN `creature_template` `ct`
                  ON `ct`.`entry` = `ie`.`creditEntry`
                JOIN `creature_template` `d1`
                  ON `d1`.`entry` = `ct`.`difficulty_entry_1`
               WHERE `ie`.`creditType` = 0
                 AND `ie`.`lastEncounterDungeon` > 0
                 AND `d1`.`lootid` <> 0
                 AND EXISTS (
                     SELECT 1 FROM `creature` `c`
                      WHERE `c`.`id1` = `ie`.`creditEntry`
                        AND `c`.`map` IN
                            (249, 309, 409, 469, 509, 531, 532, 533, 534,
                             544, 548, 550, 564, 565, 568, 580, 603, 615,
                             616, 624, 631, 649, 724))
              UNION ALL
              SELECT `d2`.`lootid`
                FROM `instance_encounters` `ie`
                JOIN `creature_template` `ct`
                  ON `ct`.`entry` = `ie`.`creditEntry`
                JOIN `creature_template` `d2`
                  ON `d2`.`entry` = `ct`.`difficulty_entry_2`
               WHERE `ie`.`creditType` = 0
                 AND `ie`.`lastEncounterDungeon` > 0
                 AND `d2`.`lootid` <> 0
                 AND EXISTS (
                     SELECT 1 FROM `creature` `c`
                      WHERE `c`.`id1` = `ie`.`creditEntry`
                        AND `c`.`map` IN
                            (249, 309, 409, 469, 509, 531, 532, 533, 534,
                             544, 548, 550, 564, 565, 568, 580, 603, 615,
                             616, 624, 631, 649, 724))
              UNION ALL
              SELECT `d3`.`lootid`
                FROM `instance_encounters` `ie`
                JOIN `creature_template` `ct`
                  ON `ct`.`entry` = `ie`.`creditEntry`
                JOIN `creature_template` `d3`
                  ON `d3`.`entry` = `ct`.`difficulty_entry_3`
               WHERE `ie`.`creditType` = 0
                 AND `ie`.`lastEncounterDungeon` > 0
                 AND `d3`.`lootid` <> 0
                 AND EXISTS (
                     SELECT 1 FROM `creature` `c`
                      WHERE `c`.`id1` = `ie`.`creditEntry`
                        AND `c`.`map` IN
                            (249, 309, 409, 469, 509, 531, 532, 533, 534,
                             544, 548, 550, 564, 565, 568, 580, 603, 615,
                             616, 624, 631, 649, 724))
              ) `raw`
       ) `raid`
 CROSS JOIN (
       SELECT @ITEM_MIASMA AS `Item`,
              'Black Miasma - Black Rose final raid bonus' AS `Name`
       UNION ALL
       SELECT @ITEM_PETALS,
              'Black Petals - Black Rose final raid bonus'
       UNION ALL
       SELECT @ITEM_THORNS,
              'Black Thorns - Black Rose final raid bonus'
       ) `currency`;
