-- DB update 2024_11_20_04 -> 2024_11_20_05
-- Markaru (20775)
UPDATE `creature_template` SET `skinloot` = 20775 WHERE (`entry` = 20775);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 20775);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(20775, 21887, 0, 79.17, 0, 1, 0, 1, 1, 'Markaru - Knothide Leather'),
(20775, 25649, 0, 20.83, 0, 1, 0, 2, 3, 'Markaru - Knothide Leather Scraps');

-- Shadowsworn Drakonid (22072)
UPDATE `creature_template` SET `skinloot` = 22072 WHERE (`entry` = 22072);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 22072);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(22072, 21887, 0, 91.3, 0, 1, 0, 1, 1, 'Shadowsworn Drakonid - Knothide Leather'),
(22072, 25649, 0, 8.7, 0, 1, 0, 2, 2, 'Shadowsworn Drakonid - Knothide Leather Scraps'),
(22072, 35229, 0, 4.35, 0, 1, 0, 1, 1, 'Shadowsworn Drakonid - Nether Residue');

-- Dragon Turtle (22885)
UPDATE `creature_template` SET `skinloot` = 22885 WHERE (`entry` = 22885);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 22885);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(22885, 21887, 0, 100.0, 0, 1, 0, 2, 4, 'Dragon Turtle - Knothide Leather');

-- Wyrmcult Blackwhelp (21387)
UPDATE `creature_template` SET `skinloot` = 21387 WHERE (`entry` = 21387);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 21387);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(21387, 21887, 0, 81.61, 0, 1, 0, 1, 1, 'Wyrmcult Blackwhelp - Knothide Leather'),
(21387, 25649, 0, 18.39, 0, 1, 0, 2, 3, 'Wyrmcult Blackwhelp - Knothide Leather Scraps');

-- Goreclaw the Ravenous (23873)
UPDATE `creature_template` SET `skinloot` = 23873 WHERE (`entry` = 23873);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 23873);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23873, 4234, 0, 75.22, 0, 1, 0, 1, 1, 'Goreclaw the Ravenous - Heavy Leather'),
(23873, 4235, 0, 4.37, 0, 1, 0, 1, 1, 'Goreclaw the Ravenous - Heavy Hide'),
(23873, 4304, 0, 20.41, 0, 1, 0, 1, 1, 'Goreclaw the Ravenous - Thick Leather');

-- Cataclysm Hound (25599)
UPDATE `creature_template` SET `skinloot` = 25599 WHERE (`entry` = 25599);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 25599);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(25599, 21887, 0, 32.76, 0, 1, 0, 1, 3, 'Cataclysm Hound - Knothide Leather'),
(25599, 25649, 0, 48.28, 0, 1, 0, 3, 4, 'Cataclysm Hound - Knothide Leather Scraps'),
(25599, 25707, 0, 18.97, 0, 1, 0, 1, 1, 'Cataclysm Hound - Fel Hide');

-- Gezzarak the Huntress (23163)
UPDATE `creature_template` SET `skinloot` = 23163 WHERE (`entry` = 23163);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 23163);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23163, 21887, 0, 44.71, 0, 1, 0, 1, 3, 'Gezzarak the Huntress - Knothide Leather'),
(23163, 25649, 0, 38.82, 0, 1, 0, 3, 4, 'Gezzarak the Huntress - Knothide Leather Scraps'),
(23163, 25707, 0, 16.47, 0, 1, 0, 1, 1, 'Gezzarak the Huntress - Fel Hide'),
(23163, 35229, 0, 1.18, 0, 1, 0, 1, 1, 'Gezzarak the Huntress - Nether Residue');

-- Tarren Mill Lookout (18094)
UPDATE `creature_template` SET `skinloot` = 18094 WHERE (`entry` = 18094);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 18094);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(18094, 21887, 0, 79.55, 0, 1, 0, 1, 1, 'Tarren Mill Lookout - Knothide Leather'),
(18094, 25649, 0, 20.45, 0, 1, 0, 2, 3, 'Tarren Mill Lookout - Knothide Leather Scraps');

-- Nerub'ar Champion (37501)
UPDATE `creature_template` SET `skinloot` = 37501 WHERE (`entry` = 37501);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 37501);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(37501, 33568, 0, 87.88, 0, 1, 0, 1, 3, 'Nerub\'ar Champion - Borean Leather'),
(37501, 38558, 0, 12.12, 0, 1, 0, 1, 2, 'Nerub\'ar Champion - Nerubian Chitin');

-- Keristrasza (26723)
UPDATE `creature_template` SET `skinloot` = 26723 WHERE (`entry` = 26723);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 26723);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26723, 33568, 0, 75.12, 0, 1, 0, 1, 3, 'Keristrasza - Borean Leather'),
(26723, 38557, 0, 24.16, 0, 1, 0, 1, 2, 'Keristrasza - Icy Dragonscale'),
(26723, 44128, 0, 0.72, 0, 1, 0, 1, 1, 'Keristrasza - Arctic Fur');

-- Nerub'ar Webweaver (37502)
UPDATE `creature_template` SET `skinloot` = 37502 WHERE (`entry` = 37502);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 37502);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(37502, 33568, 0, 72.73, 0, 1, 0, 1, 3, 'Nerub\'ar Webweaver - Borean Leather'),
(37502, 38558, 0, 27.27, 0, 1, 0, 1, 2, 'Nerub\'ar Webweaver - Nerubian Chitin');
