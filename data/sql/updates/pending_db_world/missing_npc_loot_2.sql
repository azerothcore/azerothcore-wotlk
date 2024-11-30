
-- Marauding Skeleton (10952)
UPDATE `creature_template` SET `lootid` = 10952 WHERE (`entry` = 10952);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 10952);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10952, 3419, 0, 41.67, 0, 1, 0, 1, 1, 'Marauding Skeleton - Red Rose'),
(10952, 8948, 0, 16.67, 0, 1, 0, 1, 1, 'Marauding Skeleton - Dried King Bolete'),
(10952, 16885, 0, 25.0, 0, 1, 0, 1, 1, 'Marauding Skeleton - Heavy Junkbox');

-- Marauding Corpse (10951)
UPDATE `creature_template` SET `lootid` = 10951 WHERE (`entry` = 10951);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 10951);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10951, 3419, 0, 25.0, 0, 1, 0, 1, 1, 'Marauding Corpse - Red Rose'),
(10951, 16885, 0, 25.0, 0, 1, 0, 1, 1, 'Marauding Corpse - Heavy Junkbox');

-- Whitewhisker Digger (11603)
UPDATE `creature_template` SET `lootid` = 11603 WHERE (`entry` = 11603);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 11603);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(11603, 8952, 0, 40.0, 0, 1, 0, 1, 1, 'Whitewhisker Digger - Roasted Quail');

-- Hare (5951)
UPDATE `creature_template` SET `lootid` = 5951 WHERE (`entry` = 5951);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 5951);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5951, 2934, 0, 95.24, 0, 1, 0, 1, 1, 'Hare - Ruined Leather Scraps');

-- Emberstrife (10321)
UPDATE `creature_template` SET `lootid` = 10321 WHERE (`entry` = 10321);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 10321);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10321, 8165, 0, 37.5, 0, 1, 0, 1, 1, 'Emberstrife - Worn Dragonscale'),
(10321, 8170, 0, 25.0, 0, 1, 0, 1, 1, 'Emberstrife - Rugged Leather');

-- Bloodscalp Speaker (11389)
UPDATE `creature_template` SET `lootid` = 11389 WHERE (`entry` = 11389);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 11389);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(11389, 19706, 0, 37.5, 0, 1, 0, 1, 1, 'Bloodscalp Speaker - Bloodscalp Coin');

-- Irondeep Trogg (10987)
UPDATE `creature_template` SET `lootid` = 10987 WHERE (`entry` = 10987);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 10987);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10987, 8952, 0, 66.67, 0, 1, 0, 1, 1, 'Irondeep Trogg - Roasted Quail');

-- Gaelden Hammersmith (13216)
UPDATE `creature_template` SET `lootid` = 13216 WHERE (`entry` = 13216);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 13216);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(13216, 3973, 0, 0.53, 0, 1, 0, 1, 1, 'Gaelden Hammersmith - Smooth Leather Gloves'),
(13216, 8766, 0, 0.8, 0, 1, 0, 1, 1, 'Gaelden Hammersmith - Morning Glory Dew'),
(13216, 8950, 0, 4.52, 0, 1, 0, 1, 1, 'Gaelden Hammersmith - Homemade Cherry Pie'),
(13216, 10258, 0, 0.8, 0, 1, 0, 1, 1, 'Gaelden Hammersmith - Adventurer\'s Cape'),
(13216, 13822, 0, 0.8, 0, 1, 0, 1, 1, 'Gaelden Hammersmith - Spiked Dagger'),
(13216, 14047, 0, 19.15, 0, 1, 0, 2, 4, 'Gaelden Hammersmith - Runecloth'),
(13216, 17306, 0, 40.69, 0, 1, 0, 1, 1, 'Gaelden Hammersmith - Stormpike Soldier\'s Blood'),
(13216, 17327, 0, 35.64, 0, 1, 0, 1, 1, 'Gaelden Hammersmith - Stormpike Lieutenant\'s Flesh'),
(13216, 17328, 0, 19.15, 0, 1, 0, 1, 1, 'Gaelden Hammersmith - Stormpike Commander\'s Flesh'),
(13216, 17422, 0, 78.46, 0, 1, 0, 1, 4, 'Gaelden Hammersmith - Armor Scraps');

-- Dope'rel (9040)
UPDATE `creature_template` SET `lootid` = 9040 WHERE (`entry` = 9040);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 9040);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9040, 11920, 0, 22.73, 0, 1, 0, 1, 1, 'Dope\'rel - Wraith Scythe'),
(9040, 11921, 0, 21.74, 0, 1, 0, 1, 1, 'Dope\'rel - Impervious Giant'),
(9040, 11922, 0, 23.6, 0, 1, 0, 1, 1, 'Dope\'rel - Blood-etched Blade'),
(9040, 11923, 0, 22.98, 0, 1, 0, 1, 1, 'Dope\'rel - The Hammer of Grace'),
(9040, 11925, 0, 23.48, 0, 1, 0, 1, 1, 'Dope\'rel - Ghostshroud'),
(9040, 11926, 0, 22.86, 0, 1, 0, 1, 1, 'Dope\'rel - Deathdealer Breastplate'),
(9040, 11927, 0, 23.23, 0, 1, 0, 1, 1, 'Dope\'rel - Legplates of the Eternal Guardian'),
(9040, 11929, 0, 22.11, 0, 1, 0, 1, 1, 'Dope\'rel - Haunting Specter Leggings');

-- Sickly Gazelle (12296)
UPDATE `creature_template` SET `lootid` = 12296 WHERE (`entry` = 12296);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 12296);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(12296, 2318, 0, 6.52, 0, 1, 0, 1, 1, 'Sickly Gazelle - Light Leather'),
(12296, 2934, 0, 93.48, 0, 1, 0, 1, 1, 'Sickly Gazelle - Ruined Leather Scraps');

-- Sickly Deer (12298)
UPDATE `creature_template` SET `lootid` = 12298 WHERE (`entry` = 12298);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 12298);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(12298, 2318, 0, 5.8, 0, 1, 0, 1, 1, 'Sickly Deer - Light Leather'),
(12298, 2934, 0, 94.2, 0, 1, 0, 1, 1, 'Sickly Deer - Ruined Leather Scraps');

-- Nelson the Nice (14536)
UPDATE `creature_template` SET `lootid` = 14536 WHERE (`entry` = 14536);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 14536);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14536, 18954, 0, 83.46, 0, 1, 0, 1, 1, 'Nelson the Nice - Solenor\'s Head');

-- Artorius the Amiable (14531)
UPDATE `creature_template` SET `lootid` = 14531 WHERE (`entry` = 14531);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 14531);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14531, 18955, 0, 88.13, 0, 1, 0, 1, 1, 'Artorius the Amiable - Artorius\'s Head');

-- Colossus of Zora (15740)
UPDATE `creature_template` SET `lootid` = 15740 WHERE (`entry` = 15740);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 15740);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(15740, 833, 0, 25.0, 0, 1, 0, 1, 1, 'Colossus of Zora - Lifestone'),
(15740, 2099, 0, 50.0, 0, 1, 0, 1, 1, 'Colossus of Zora - Dwarven Hand Cannon'),
(15740, 3475, 0, 41.67, 0, 1, 0, 1, 1, 'Colossus of Zora - Cloak of Flames'),
(15740, 13008, 0, 41.67, 0, 1, 0, 1, 1, 'Colossus of Zora - Dalewind Trousers'),
(15740, 13036, 0, 25.0, 0, 1, 0, 1, 1, 'Colossus of Zora - Assassination Blade'),
(15740, 13077, 0, 25.0, 0, 1, 0, 1, 1, 'Colossus of Zora - Girdle of Uther'),
(15740, 13107, 0, 66.67, 0, 1, 0, 1, 1, 'Colossus of Zora - Magiskull Cuffs'),
(15740, 13116, 0, 41.67, 0, 1, 0, 1, 1, 'Colossus of Zora - Spaulders of the Unseen'),
(15740, 14554, 0, 41.67, 0, 1, 0, 1, 1, 'Colossus of Zora - Cloudkeeper Legplates');

-- Simone the Inconspicuous (14527)
UPDATE `creature_template` SET `lootid` = 14527 WHERE (`entry` = 14527);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 14527);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14527, 18952, 0, 87.99, 0, 1, 0, 1, 1, 'Simone the Inconspicuous - Simone\'s Head');

-- Majordomo Executus (12018)
UPDATE `creature_template` SET `lootid` = 12018 WHERE (`entry` = 12018);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 12018);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(12018, 18646, 0, 49.08, 0, 1, 0, 1, 1, 'Majordomo Executus - The Eye of Divinity'),
(12018, 18703, 0, 47.01, 0, 1, 0, 1, 1, 'Majordomo Executus - Ancient Petrified Leaf'),
(12018, 18803, 0, 17.92, 0, 1, 0, 1, 1, 'Majordomo Executus - Hyperthermically Insulated Lava Dredger'),
(12018, 18805, 0, 18.02, 0, 1, 0, 1, 1, 'Majordomo Executus - Core Hound Tooth'),
(12018, 18806, 0, 19.22, 0, 1, 0, 1, 1, 'Majordomo Executus - Core Forged Greaves'),
(12018, 18808, 0, 22.58, 0, 1, 0, 1, 1, 'Majordomo Executus - Gloves of the Hypnotic Flame'),
(12018, 18809, 0, 17.7, 0, 1, 0, 1, 1, 'Majordomo Executus - Sash of Whispered Secrets'),
(12018, 18810, 0, 19.0, 0, 1, 0, 1, 1, 'Majordomo Executus - Wild Growth Spaulders'),
(12018, 18811, 0, 18.78, 0, 1, 0, 1, 1, 'Majordomo Executus - Fireproof Cloak'),
(12018, 18812, 0, 18.78, 0, 1, 0, 1, 1, 'Majordomo Executus - Wristguards of True Flight'),
(12018, 19139, 0, 18.02, 0, 1, 0, 1, 1, 'Majordomo Executus - Fireguard Shoulders'),
(12018, 19140, 0, 21.61, 0, 1, 0, 1, 1, 'Majordomo Executus - Cauterizing Band');

-- Plagued Deathhound (16448)
UPDATE `creature_template` SET `lootid` = 16448 WHERE (`entry` = 16448);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 16448);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(16448, 4583, 0, 14.71, 0, 1, 0, 1, 1, 'Plagued Deathhound - Thick Furry Mane'),
(16448, 4584, 0, 6.68, 0, 1, 0, 1, 1, 'Plagued Deathhound - Large Trophy Paw'),
(16448, 17683, 0, 0.27, 0, 1, 0, 1, 1, 'Plagued Deathhound - Book: Gift of the Wild II'),
(16448, 22373, 0, 22.46, 0, 1, 0, 1, 1, 'Plagued Deathhound - Wartorn Leather Scrap'),
(16448, 22374, 0, 11.76, 0, 1, 0, 1, 1, 'Plagued Deathhound - Wartorn Chain Scrap'),
(16448, 22375, 0, 20.32, 0, 1, 0, 1, 1, 'Plagued Deathhound - Wartorn Plate Scrap'),
(16448, 22376, 0, 24.33, 0, 1, 0, 1, 1, 'Plagued Deathhound - Wartorn Cloth Scrap'),
(16448, 22708, 0, 0.53, 0, 1, 0, 1, 1, 'Plagued Deathhound - Fate of Ramaladni'),
(16448, 23055, 0, 5.35, 0, 1, 0, 1, 1, 'Plagued Deathhound - Word of Thawing');

-- Franklin the Friendly (14529)
UPDATE `creature_template` SET `lootid` = 14529 WHERE (`entry` = 14529);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 14529);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14529, 18953, 0, 88.66, 0, 1, 0, 1, 1, 'Franklin the Friendly - Klinfran\'s Head');
