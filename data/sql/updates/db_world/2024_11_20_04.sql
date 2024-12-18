-- DB update 2024_11_20_03 -> 2024_11_20_04
-- Sorrow Wing (5928)
UPDATE `creature_template` SET `skinloot` = 5928 WHERE (`entry` = 5928);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 5928);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5928, 2319, 0, 67.12, 0, 1, 0, 1, 2, 'Sorrow Wing - Medium Leather'),
(5928, 4232, 0, 8.22, 0, 1, 0, 1, 1, 'Sorrow Wing - Medium Hide'),
(5928, 4234, 0, 23.29, 0, 1, 0, 1, 2, 'Sorrow Wing - Heavy Leather'),
(5928, 4235, 0, 1.37, 0, 1, 0, 1, 1, 'Sorrow Wing - Heavy Hide');

-- Sickly Gazelle (12296)
UPDATE `creature_template` SET `skinloot` = 12296 WHERE (`entry` = 12296);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 12296);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(12296, 2318, 0, 9.74, 0, 1, 0, 1, 1, 'Sickly Gazelle - Light Leather'),
(12296, 2934, 0, 90.28, 0, 1, 0, 1, 1, 'Sickly Gazelle - Ruined Leather Scraps');

-- Brokentoe (18398)
UPDATE `creature_template` SET `skinloot` = 18398 WHERE (`entry` = 18398);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 18398);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(18398, 21887, 0, 25.97, 0, 1, 0, 1, 1, 'Brokentoe - Knothide Leather'),
(18398, 25649, 0, 40.26, 0, 1, 0, 2, 3, 'Brokentoe - Knothide Leather Scraps'),
(18398, 25708, 0, 33.77, 0, 1, 0, 1, 1, 'Brokentoe - Thick Clefthoof Leather');

-- Skunk (17467)
UPDATE `creature_template` SET `skinloot` = 17467 WHERE (`entry` = 17467);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 17467);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(17467, 2318, 0, 5.56, 0, 1, 0, 1, 1, 'Skunk - Light Leather'),
(17467, 2934, 0, 94.44, 0, 1, 0, 1, 1, 'Skunk - Ruined Leather Scraps');

-- Ethereum Prisoner (20520)
UPDATE `creature_template` SET `skinloot` = 20520 WHERE (`entry` = 20520);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 20520);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(20520, 21887, 0, 24.65, 0, 1, 0, 1, 1, 'Ethereum Prisoner - Knothide Leather'),
(20520, 25649, 0, 30.63, 0, 1, 0, 2, 3, 'Ethereum Prisoner - Knothide Leather Scraps'),
(20520, 25699, 0, 22.54, 0, 1, 0, 1, 1, 'Ethereum Prisoner - Crystal Infused Leather'),
(20520, 25700, 0, 22.18, 0, 1, 0, 1, 1, 'Ethereum Prisoner - Fel Scales');

-- Tarren Mill Protector (18093)
UPDATE `creature_template` SET `skinloot` = 18093 WHERE (`entry` = 18093);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 18093);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(18093, 21887, 0, 78.83, 0, 1, 0, 1, 1, 'Tarren Mill Protector - Knothide Leather'),
(18093, 25649, 0, 21.17, 0, 1, 0, 2, 3, 'Tarren Mill Protector - Knothide Leather Scraps');

-- Deathclaw (17661)
UPDATE `creature_template` SET `skinloot` = 17661 WHERE (`entry` = 17661);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 17661);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(17661, 783, 0, 1.18, 0, 1, 0, 1, 1, 'Deathclaw - Light Hide'),
(17661, 2318, 0, 78.82, 0, 1, 0, 1, 2, 'Deathclaw - Light Leather'),
(17661, 2319, 0, 20.0, 0, 1, 0, 1, 1, 'Deathclaw - Medium Leather');

-- Infinite Chrono-Lord (21697)
UPDATE `creature_template` SET `skinloot` = 21697 WHERE (`entry` = 21697);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 21697);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(21697, 21887, 0, 100.0, 0, 1, 0, 2, 4, 'Infinite Chrono-Lord - Knothide Leather');

-- Tarren Mill Guardsman (18092)
UPDATE `creature_template` SET `skinloot` = 18092 WHERE (`entry` = 18092);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 18092);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(18092, 21887, 0, 80.0, 0, 1, 0, 1, 1, 'Tarren Mill Guardsman - Knothide Leather'),
(18092, 25649, 0, 20.0, 0, 1, 0, 2, 3, 'Tarren Mill Guardsman - Knothide Leather Scraps');

-- Vazruden the Herald (17307)
UPDATE `creature_template` SET `skinloot` = 17307 WHERE (`entry` = 17307);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 17307);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(17307, 21887, 0, 100.0, 0, 1, 0, 1, 4, 'Vazruden the Herald - Knothide Leather');
