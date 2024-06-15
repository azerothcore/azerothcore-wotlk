-- DB update 2023_03_27_01 -> 2023_03_27_02
-- Repair Pathaleon the Calculator Loot Table
UPDATE `reference_loot_template` SET `GroupId`=5 WHERE `Entry`=35005 AND `Item` IN (28285, 28278, 28286, 28288, 28275, 27899);
DELETE FROM `creature_loot_template` WHERE `Entry`=19220 AND `Item`=35005 AND `Reference`=35005 AND `GroupId`=5;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES (19220, 35005, 35005, 100, 0, 1, 5, 1, 1, 'Pathaleon the Calculator - High Value Table (ReferenceTable)');
