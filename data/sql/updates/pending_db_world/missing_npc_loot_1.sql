
-- Hans Zandin (2396)
UPDATE `creature_template` SET `lootid` = 2396 WHERE (`entry` = 2396);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 2396);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2396, 4306, 0, 75.0, 0, 1, 0, 2, 2, 'Hans Zandin - Silk Cloth');

-- Fawn (890)
UPDATE `creature_template` SET `lootid` = 890 WHERE (`entry` = 890);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 890);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(890, 2318, 0, 13.33, 0, 1, 0, 1, 1, 'Fawn - Light Leather'),
(890, 2934, 0, 86.67, 0, 1, 0, 1, 1, 'Fawn - Ruined Leather Scraps');

-- Tamara Armstrong (2361)
UPDATE `creature_template` SET `lootid` = 2361 WHERE (`entry` = 2361);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 2361);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2361, 2589, 0, 100.0, 0, 1, 0, 1, 3, 'Tamara Armstrong - Linen Cloth');

-- Eastvale Lumberjack (1975)
UPDATE `creature_template` SET `lootid` = 1975 WHERE (`entry` = 1975);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 1975);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1975, 2589, 0, 75.0, 0, 1, 0, 1, 1, 'Eastvale Lumberjack - Linen Cloth');

-- Delia Verana (2392)
UPDATE `creature_template` SET `lootid` = 2392 WHERE (`entry` = 2392);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 2392);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2392, 2592, 0, 60.0, 0, 1, 0, 1, 1, 'Delia Verana - Wool Cloth'),
(2392, 4306, 0, 40.0, 0, 1, 0, 2, 2, 'Delia Verana - Silk Cloth');

-- Lordaeron Citizen (3617)
UPDATE `creature_template` SET `lootid` = 3617 WHERE (`entry` = 3617);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 3617);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3617, 2589, 0, 95.0, 0, 1, 0, 1, 3, 'Lordaeron Citizen - Linen Cloth');

-- Stanley (2274)
UPDATE `creature_template` SET `lootid` = 2274 WHERE (`entry` = 2274);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 2274);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2274, 2319, 0, 66.67, 0, 1, 0, 1, 1, 'Stanley - Medium Leather');

-- Maiden's Virtue Crewman (2099)
UPDATE `creature_template` SET `lootid` = 2099 WHERE (`entry` = 2099);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 2099);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2099, 2589, 0, 34.18, 0, 1, 0, 1, 3, 'Maiden\'s Virtue Crewman - Linen Cloth'),
(2099, 2592, 0, 36.71, 0, 1, 0, 1, 2, 'Maiden\'s Virtue Crewman - Wool Cloth');

-- Rabbit (721)
UPDATE `creature_template` SET `lootid` = 721 WHERE (`entry` = 721);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 721);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(721, 2934, 0, 73.33, 0, 1, 0, 1, 1, 'Rabbit - Ruined Leather Scraps');

-- Cow (2442)
UPDATE `creature_template` SET `lootid` = 2442 WHERE (`entry` = 2442);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 2442);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2442, 2318, 0, 8.07, 0, 1, 0, 1, 1, 'Cow - Light Leather'),
(2442, 2934, 0, 90.68, 0, 1, 0, 1, 1, 'Cow - Ruined Leather Scraps');

-- Sheep (1933)
UPDATE `creature_template` SET `lootid` = 1933 WHERE (`entry` = 1933);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 1933);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1933, 2318, 0, 9.91, 0, 1, 0, 1, 1, 'Sheep - Light Leather'),
(1933, 2592, 0, 34.23, 0, 1, 0, 1, 1, 'Sheep - Wool Cloth'),
(1933, 2934, 0, 55.86, 0, 1, 0, 1, 1, 'Sheep - Ruined Leather Scraps');

-- Hemmit Armstrong (2362)
UPDATE `creature_template` SET `lootid` = 2362 WHERE (`entry` = 2362);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 2362);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2362, 2589, 0, 50.0, 0, 1, 0, 2, 2, 'Hemmit Armstrong - Linen Cloth');

-- Ram (2098)
UPDATE `creature_template` SET `lootid` = 2098 WHERE (`entry` = 2098);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 2098);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2098, 2318, 0, 12.5, 0, 1, 0, 1, 1, 'Ram - Light Leather'),
(2098, 2934, 0, 81.25, 0, 1, 0, 1, 1, 'Ram - Ruined Leather Scraps');

-- Death's Head Ward Keeper (4625)
UPDATE `creature_template` SET `lootid` = 4625 WHERE (`entry` = 4625);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 4625);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4625, 5369, 0, 66.67, 0, 1, 0, 1, 1, 'Death\'s Head Ward Keeper - Gnawed Bone');

-- Konda (1516)
UPDATE `creature_template` SET `lootid` = 1516 WHERE (`entry` = 1516);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 1516);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1516, 4234, 0, 41.05, 0, 1, 0, 1, 1, 'Konda - Heavy Leather'),
(1516, 4235, 0, 2.11, 0, 1, 0, 1, 1, 'Konda - Heavy Hide'),
(1516, 4304, 0, 36.84, 0, 1, 0, 1, 1, 'Konda - Thick Leather');

-- Gazelle (4166)
UPDATE `creature_template` SET `lootid` = 4166 WHERE (`entry` = 4166);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 4166);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4166, 2318, 0, 11.96, 0, 1, 0, 1, 1, 'Gazelle - Light Leather'),
(4166, 2934, 0, 88.04, 0, 1, 0, 1, 1, 'Gazelle - Ruined Leather Scraps');

-- Deer (883)
UPDATE `creature_template` SET `lootid` = 883 WHERE (`entry` = 883);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 883);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(883, 2318, 0, 8.19, 0, 1, 0, 1, 1, 'Deer - Light Leather'),
(883, 2934, 0, 91.47, 0, 1, 0, 1, 1, 'Deer - Ruined Leather Scraps'),
(883, 7073, 0, 0.68, 0, 1, 0, 1, 1, 'Deer - Broken Fang');

-- Venture Co. Lookout (7307)
UPDATE `creature_template` SET `lootid` = 7307 WHERE (`entry` = 7307);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 7307);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(7307, 16882, 0, 75.0, 0, 1, 0, 1, 1, 'Venture Co. Lookout - Battered Junkbox');

-- Mutated Venture Co. Drone (7310)
UPDATE `creature_template` SET `lootid` = 7310 WHERE (`entry` = 7310);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 7310);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(7310, 16882, 0, 66.67, 0, 1, 0, 1, 1, 'Mutated Venture Co. Drone - Battered Junkbox');

-- Hakkari Minion (8437)
UPDATE `creature_template` SET `lootid` = 8437 WHERE (`entry` = 8437);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 8437);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(8437, 4234, 0, 20.0, 0, 1, 0, 1, 1, 'Hakkari Minion - Heavy Leather'),
(8437, 4235, 0, 20.0, 0, 1, 0, 1, 1, 'Hakkari Minion - Heavy Hide'),
(8437, 4304, 0, 40.0, 0, 1, 0, 1, 1, 'Hakkari Minion - Thick Leather');

-- Booty Bay Bruiser (4624)
UPDATE `creature_template` SET `lootid` = 4624 WHERE (`entry` = 4624);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 4624);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4624, 3928, 0, 40.0, 0, 1, 0, 1, 1, 'Booty Bay Bruiser - Superior Healing Potion'),
(4624, 5428, 0, 40.0, 0, 1, 0, 1, 1, 'Booty Bay Bruiser - An Exotic Cookbook');
