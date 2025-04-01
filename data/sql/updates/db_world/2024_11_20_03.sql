-- DB update 2024_11_20_02 -> 2024_11_20_03
-- Rabbit (721)
UPDATE `creature_template` SET `skinloot` = 721 WHERE (`entry` = 721);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 721);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(721, 2318, 0, 10.53, 0, 1, 0, 1, 1, 'Rabbit - Light Leather'),
(721, 2934, 0, 89.47, 0, 1, 0, 1, 1, 'Rabbit - Ruined Leather Scraps');

-- Nefaru (534)
UPDATE `creature_template` SET `skinloot` = 534 WHERE (`entry` = 534);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 534);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(534, 2319, 0, 40.86, 0, 1, 0, 1, 1, 'Nefaru - Medium Leather'),
(534, 4232, 0, 2.15, 0, 1, 0, 1, 1, 'Nefaru - Medium Hide'),
(534, 4234, 0, 52.69, 0, 1, 0, 1, 1, 'Nefaru - Heavy Leather'),
(534, 4235, 0, 4.3, 0, 1, 0, 1, 1, 'Nefaru - Heavy Hide');

-- Pyrewood Tailor (3530)
UPDATE `creature_template` SET `skinloot` = 3530 WHERE (`entry` = 3530);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 3530);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3530, 783, 0, 4.55, 0, 1, 0, 1, 1, 'Pyrewood Tailor - Light Hide'),
(3530, 2318, 0, 86.36, 0, 1, 0, 1, 1, 'Pyrewood Tailor - Light Leather'),
(3530, 2934, 0, 9.09, 0, 1, 0, 1, 1, 'Pyrewood Tailor - Ruined Leather Scraps');

-- Cow (2442)
UPDATE `creature_template` SET `skinloot` = 2442 WHERE (`entry` = 2442);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 2442);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2442, 2318, 0, 10.72, 0, 1, 0, 1, 1, 'Cow - Light Leather'),
(2442, 2934, 0, 89.29, 0, 1, 0, 1, 1, 'Cow - Ruined Leather Scraps');

-- Pyrewood Watcher (1891)
UPDATE `creature_template` SET `skinloot` = 1891 WHERE (`entry` = 1891);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 1891);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1891, 783, 0, 3.16, 0, 1, 0, 1, 1, 'Pyrewood Watcher - Light Hide'),
(1891, 2318, 0, 63.16, 0, 1, 0, 1, 1, 'Pyrewood Watcher - Light Leather'),
(1891, 2934, 0, 33.68, 0, 1, 0, 1, 1, 'Pyrewood Watcher - Ruined Leather Scraps');

-- Infected Deer (10780)
UPDATE `creature_template` SET `skinloot` = 10780 WHERE (`entry` = 10780);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 10780);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10780, 2318, 0, 10.1, 0, 1, 0, 1, 1, 'Infected Deer - Light Leather'),
(10780, 2934, 0, 89.9, 0, 1, 0, 1, 1, 'Infected Deer - Ruined Leather Scraps');

-- Pyrewood Elder (1895)
UPDATE `creature_template` SET `skinloot` = 1895 WHERE (`entry` = 1895);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 1895);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1895, 783, 0, 5.51, 0, 1, 0, 1, 1, 'Pyrewood Elder - Light Hide'),
(1895, 2318, 0, 63.78, 0, 1, 0, 1, 1, 'Pyrewood Elder - Light Leather'),
(1895, 2934, 0, 30.71, 0, 1, 0, 1, 1, 'Pyrewood Elder - Ruined Leather Scraps');

-- Sickly Deer (12298)
UPDATE `creature_template` SET `skinloot` = 12298 WHERE (`entry` = 12298);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 12298);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(12298, 2318, 0, 10.06, 0, 1, 0, 1, 1, 'Sickly Deer - Light Leather'),
(12298, 2934, 0, 89.94, 0, 1, 0, 1, 1, 'Sickly Deer - Ruined Leather Scraps');

-- Hare (5951)
UPDATE `creature_template` SET `skinloot` = 5951 WHERE (`entry` = 5951);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 5951);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5951, 2318, 0, 9.13, 0, 1, 0, 1, 1, 'Hare - Light Leather'),
(5951, 2934, 0, 90.87, 0, 1, 0, 1, 1, 'Hare - Ruined Leather Scraps');

-- Hakkari Minion (8437)
UPDATE `creature_template` SET `skinloot` = 8437 WHERE (`entry` = 8437);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 8437);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(8437, 4234, 0, 43.94, 0, 1, 0, 1, 1, 'Hakkari Minion - Heavy Leather'),
(8437, 4235, 0, 3.46, 0, 1, 0, 1, 1, 'Hakkari Minion - Heavy Hide'),
(8437, 4304, 0, 48.44, 0, 1, 0, 1, 1, 'Hakkari Minion - Thick Leather'),
(8437, 8169, 0, 4.15, 0, 1, 0, 1, 1, 'Hakkari Minion - Thick Hide');
