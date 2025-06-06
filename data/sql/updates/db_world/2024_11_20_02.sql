-- DB update 2024_11_20_01 -> 2024_11_20_02
-- Deer (883)
UPDATE `creature_template` SET `skinloot` = 883 WHERE (`entry` = 883);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 883);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(883, 2318, 0, 9.92, 0, 1, 0, 1, 1, 'Deer - Light Leather'),
(883, 2934, 0, 90.08, 0, 1, 0, 1, 1, 'Deer - Ruined Leather Scraps');

-- Fawn (890)
UPDATE `creature_template` SET `skinloot` = 890 WHERE (`entry` = 890);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 890);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(890, 2318, 0, 11.1, 0, 1, 0, 1, 1, 'Fawn - Light Leather'),
(890, 2934, 0, 88.9, 0, 1, 0, 1, 1, 'Fawn - Ruined Leather Scraps');

-- Pyrewood Leatherworker (3532)
UPDATE `creature_template` SET `skinloot` = 3532 WHERE (`entry` = 3532);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 3532);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3532, 783, 0, 6.67, 0, 1, 0, 1, 1, 'Pyrewood Leatherworker - Light Hide'),
(3532, 2318, 0, 93.33, 0, 1, 0, 1, 1, 'Pyrewood Leatherworker - Light Leather');

-- Ram (2098)
UPDATE `creature_template` SET `skinloot` = 2098 WHERE (`entry` = 2098);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 2098);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2098, 2318, 0, 7.84, 0, 1, 0, 1, 1, 'Ram - Light Leather'),
(2098, 2934, 0, 92.16, 0, 1, 0, 1, 1, 'Ram - Ruined Leather Scraps');

-- Prairie Dog (2620)
UPDATE `creature_template` SET `skinloot` = 2620 WHERE (`entry` = 2620);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 2620);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2620, 2318, 0, 6.06, 0, 1, 0, 1, 1, 'Prairie Dog - Light Leather'),
(2620, 2934, 0, 93.94, 0, 1, 0, 1, 1, 'Prairie Dog - Ruined Leather Scraps');

-- Pyrewood Sentry (1894)
UPDATE `creature_template` SET `skinloot` = 1894 WHERE (`entry` = 1894);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 1894);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1894, 783, 0, 6.1, 0, 1, 0, 1, 1, 'Pyrewood Sentry - Light Hide'),
(1894, 2318, 0, 55.69, 0, 1, 0, 1, 1, 'Pyrewood Sentry - Light Leather'),
(1894, 2934, 0, 38.21, 0, 1, 0, 1, 1, 'Pyrewood Sentry - Ruined Leather Scraps');

-- Sheep (1933)
UPDATE `creature_template` SET `skinloot` = 1933 WHERE (`entry` = 1933);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 1933);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1933, 2318, 0, 9.0, 0, 1, 0, 1, 1, 'Sheep - Light Leather'),
(1933, 2592, 0, 22.89, 0, 1, 0, 1, 1, 'Sheep - Wool Cloth'),
(1933, 2934, 0, 61.45, 0, 1, 0, 1, 1, 'Sheep - Ruined Leather Scraps');

-- Gazelle (4166)
UPDATE `creature_template` SET `skinloot` = 4166 WHERE (`entry` = 4166);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 4166);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4166, 2318, 0, 10.19, 0, 1, 0, 1, 1, 'Gazelle - Light Leather'),
(4166, 2934, 0, 89.81, 0, 1, 0, 1, 2, 'Gazelle - Ruined Leather Scraps');

-- Vagash (1388)
UPDATE `creature_template` SET `skinloot` = 1388 WHERE (`entry` = 1388);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 1388);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1388, 783, 0, 4.76, 0, 1, 0, 1, 1, 'Vagash - Light Hide'),
(1388, 2318, 0, 60.32, 0, 1, 0, 1, 2, 'Vagash - Light Leather'),
(1388, 2934, 0, 34.92, 0, 1, 0, 1, 1, 'Vagash - Ruined Leather Scraps');

-- Stormwind Royal Guard (1756)
UPDATE `creature_template` SET `skinloot` = 1756 WHERE (`entry` = 1756);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 1756);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1756, 4304, 0, 4.51, 0, 1, 0, 1, 2, 'Stormwind Royal Guard - Thick Leather'),
(1756, 8165, 0, 11.41, 0, 1, 0, 1, 1, 'Stormwind Royal Guard - Worn Dragonscale'),
(1756, 8170, 0, 54.77, 0, 1, 0, 1, 2, 'Stormwind Royal Guard - Rugged Leather'),
(1756, 8171, 0, 5.44, 0, 1, 0, 1, 1, 'Stormwind Royal Guard - Rugged Hide'),
(1756, 15416, 0, 23.87, 0, 1, 0, 1, 1, 'Stormwind Royal Guard - Black Dragonscale');
