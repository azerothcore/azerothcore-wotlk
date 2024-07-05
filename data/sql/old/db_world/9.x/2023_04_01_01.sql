-- DB update 2023_04_01_00 -> 2023_04_01_01
--
-- Harbinger Skyriss Normal Loot
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=25004 AND `Item` IN (28413, 28414, 28415, 28416, 28418, 28419);
DELETE FROM `creature_loot_template` WHERE `Entry`=20912 AND `Item`=25004 AND `Reference`=25004 AND `GroupId`=3;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES (20912, 25004, 25004, 100, 0, 1, 3, 1, 1, 'Harbinger Skyriss - High Value Table (ReferenceTable)');
