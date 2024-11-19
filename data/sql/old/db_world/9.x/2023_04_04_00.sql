-- DB update 2023_04_03_00 -> 2023_04_04_00
-- Blood of the Mountain
DELETE FROM `creature_loot_template` WHERE `Item` = 11382;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(11659, 11382, 0, 7.1259, 0, 1, 0, 1, 1, 'Molten Destroyer - Blood of the Mountain');
