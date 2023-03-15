-- DB update 2023_03_15_01 -> 2023_03_15_02
--
-- Repair Warp Splinter Loot Table
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=35006 AND `Item` IN (28370, 28367, 28371, 28348, 28350, 28349);
UPDATE `creature_loot_template` SET `MaxCount`=1 WHERE `Entry`=17977 AND `Item`=35006 AND `Reference`=35006 AND `GroupId`=2;
DELETE FROM `creature_loot_template` WHERE  `Entry`=17977 AND `Item`=35006 AND `Reference`=35006 AND `GroupId`=3;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES (17977, 35006, 35006, 100, 0, 1, 3, 1, 1, 'Warp Splinter High Value Table - (ReferenceTable)');
