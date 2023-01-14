-- DB update 2023_01_07_07 -> 2023_01_13_00
-- Create a new skinning loot with right percentage
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 70068) AND (`Item` IN (21887, 25649, 35229));
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(70068, 21887, 0, 80, 0, 1, 1, 1, 1, 'Knothide Leather'),
(70068, 25649, 0, 0, 0, 1, 1, 2, 3, 'Knothide Leather Scraps'),
(70068, 35229, 0, 25, 1, 1, 0, 1, 1, 'Nether Residue');

-- Creature with 80% Knothide Leather and 20% Knothide Leather Scraps
UPDATE `creature_template` SET `skinloot`= 70068 WHERE (`entry` IN (21879, 21408, 21864, 21901, 21462, 21878, 21195, 20610, 20773, 18879, 20671, 20634, 18880, 20777));

-- Create a new skinning loot with right percentage
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 70069) AND `Item` IN (21887, 35229);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(70069, 21887, 0, 0, 0, 1, 1, 1, 1, 'Knothide Leather'),
(70069, 35229, 0, 25, 1, 1, 0, 1, 1, 'Nether Residue');

-- Creature with 100% Knothide Leather
UPDATE `creature_template` SET `skinloot`= 70069 WHERE (`entry` IN (23501, 22181));
