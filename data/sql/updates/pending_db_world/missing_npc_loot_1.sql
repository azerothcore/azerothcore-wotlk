
-- Hans Zandin (2396)
UPDATE `creature_template` SET `lootid` = 2396 WHERE (`entry` = 2396);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 2396);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2396, 4306, 0, 75.0, 0, 1, 0, 2, 2, 'Hans Zandin - Silk Cloth');

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

-- Maiden's Virtue Crewman (2099)
UPDATE `creature_template` SET `lootid` = 2099 WHERE (`entry` = 2099);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 2099);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2099, 2589, 0, 34.18, 0, 1, 0, 1, 3, 'Maiden\'s Virtue Crewman - Linen Cloth'),
(2099, 2592, 0, 36.71, 0, 1, 0, 1, 2, 'Maiden\'s Virtue Crewman - Wool Cloth');

-- Hemmit Armstrong (2362)
UPDATE `creature_template` SET `lootid` = 2362 WHERE (`entry` = 2362);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 2362);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2362, 2589, 0, 50.0, 0, 1, 0, 2, 2, 'Hemmit Armstrong - Linen Cloth');

-- Death's Head Ward Keeper (4625)
UPDATE `creature_template` SET `lootid` = 4625 WHERE (`entry` = 4625);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 4625);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4625, 5369, 0, 66.67, 0, 1, 0, 1, 1, 'Death\'s Head Ward Keeper - Gnawed Bone');

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

-- Booty Bay Bruiser (4624)
UPDATE `creature_template` SET `lootid` = 4624 WHERE (`entry` = 4624);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 4624);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4624, 3928, 0, 40.0, 0, 1, 0, 1, 1, 'Booty Bay Bruiser - Superior Healing Potion'),
(4624, 5428, 0, 40.0, 0, 1, 0, 1, 1, 'Booty Bay Bruiser - An Exotic Cookbook');
