-- DB update 2022_10_06_05 -> 2022_10_07_00
-- Idols
UPDATE `creature_loot_template` SET `Chance`=0.4 WHERE `Item` IN (20874, 20875, 20876, 20877, 20878, 20879, 20881, 20882);

-- The Prophet Skeram
DELETE FROM `reference_loot_template` WHERE `Entry`=34046;
DELETE FROM `creature_loot_template` WHERE (`Entry` = 15263) AND (`Item` IN (34045, 34046, 21128, 21698, 21699, 21700, 21701, 21702, 21703, 21704, 21705, 21706, 21707, 21708, 21814));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(15263, 21128, 0, 10, 0, 1, 1, 1, 1, 'The Prophet Skeram - Staff of the Qiraji Prophets'),
(15263, 21698, 0, 0, 0, 1, 1, 1, 1, 'The Prophet Skeram - Leggings of Immersion'),
(15263, 21699, 0, 0, 0, 1, 1, 1, 1, 'The Prophet Skeram - Barrage Shoulders'),
(15263, 21700, 0, 0, 0, 1, 1, 1, 1, 'The Prophet Skeram - Pendant of the Qiraji Guardian'),
(15263, 21701, 0, 0, 0, 1, 1, 1, 1, 'The Prophet Skeram - Cloak of Concentrated Hatred'),
(15263, 21702, 0, 0, 0, 1, 1, 1, 1, 'The Prophet Skeram - Amulet of Foul Warding'),
(15263, 21703, 0, 10, 0, 1, 2, 1, 1, 'The Prophet Skeram - Hammer of Ji\'zhi'),
(15263, 21704, 0, 0, 0, 1, 2, 1, 1, 'The Prophet Skeram -  Boots of the Redeemed Prophecy'),
(15263, 21705, 0, 0, 0, 1, 2, 1, 1, 'The Prophet Skeram - Boots of the Fallen Prophet'),
(15263, 21706, 0, 0, 0, 1, 2, 1, 1, 'The Prophet Skeram - Boots of the Unwavering Will'),
(15263, 21707, 0, 0, 0, 1, 2, 1, 1, 'The Prophet Skeram - Ring of Swarming Thought'),
(15263, 21708, 0, 0, 0, 1, 2, 1, 1, 'The Prophet Skeram - Beetle Scaled Wristguards'),
(15263, 21814, 0, 0, 0, 1, 2, 1, 1, 'The Prophet Skeram - Breastplate of Annihilation'),
(15263, 34045, 34045, 7, 0, 1, 0, 1, 1, 'The Prophet Skeram - Reference Table');

-- Battleguard Sartura
DELETE FROM `reference_loot_template` WHERE `Entry`=34047;
DELETE FROM `creature_loot_template` WHERE (`Entry` = 15516) AND (`Item` IN (34047, 21648, 21666, 21667, 21668, 21669, 21670, 21671, 21672, 21673, 21674, 21675, 21676, 21678));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(15516, 21648, 0, 0, 0, 1, 2, 1, 1, 'Battleguard Sartura - Recomposed Boots'),
(15516, 21666, 0, 7.7, 0, 1, 1, 1, 1, 'Battleguard Sartura - Sartura\'s Might'),
(15516, 21667, 0, 0, 0, 1, 1, 1, 1, 'Battleguard Sartura - Legplates of Blazing Light'),
(15516, 21668, 0, 0, 0, 1, 1, 1, 1, 'Battleguard Sartura - Scaled Leggings of Qiraji Fury'),
(15516, 21669, 0, 0, 0, 1, 1, 1, 1, 'Battleguard Sartura - Creeping Vine Helm'),
(15516, 21670, 0, 0, 0, 1, 1, 1, 1, 'Battleguard Sartura - Badge of the Swarmguard'),
(15516, 21671, 0, 0, 0, 1, 1, 1, 1, 'Battleguard Sartura - Robes of the Battleguard'),
(15516, 21672, 0, 0, 0, 1, 1, 1, 1, 'Battleguard Sartura - Gloves of Enforcement'),
(15516, 21673, 0, 9.09, 0, 1, 2, 1, 1, 'Battleguard Sartura - Silithid Claw'),
(15516, 21674, 0, 0, 0, 1, 2, 1, 1, 'Battleguard Sartura - Gauntlets of Steadfast Determination'),
(15516, 21675, 0, 0, 0, 1, 2, 1, 1, 'Battleguard Sartura - Thick Qirajihide Belt'),
(15516, 21676, 0, 0, 0, 1, 2, 1, 1, 'Battleguard Sartura - Leggings of the Festering Swarm'),
(15516, 21678, 0, 0, 0, 1, 2, 1, 1, 'Battleguard Sartura - Necklace of Purity');

-- Fankriss the Unyielding
DELETE FROM `reference_loot_template` WHERE `Entry`=34048;
DELETE FROM `creature_loot_template` WHERE (`Entry` = 15510) AND (`Item` IN (34048, 21627, 21635, 21639, 21645, 21647, 21650, 21651, 21652, 21663, 21664, 21665, 22396, 22402));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(15510, 21627, 0, 0, 0, 1, 2, 1, 1, 'Fankriss the Unyielding - Cloak of Untold Secrets'),
(15510, 21635, 0, 10, 0, 1, 2, 1, 1, 'Fankriss the Unyielding - Barb of the Sand Reaver'),
(15510, 21639, 0, 0, 0, 1, 1, 1, 1, 'Fankriss the Unyielding - Pauldrons of the Unrelenting'),
(15510, 21645, 0, 0, 0, 1, 2, 1, 1, 'Fankriss the Unyielding - Hive Tunneler\'s Boots'),
(15510, 21647, 0, 0, 0, 1, 2, 1, 1, 'Fankriss the Unyielding - Fetish of the Sand Reaver'),
(15510, 21650, 0, 10, 0, 1, 1, 1, 1, 'Fankriss the Unyielding - Ancient Qiraji Ripper'),
(15510, 21651, 0, 0, 0, 1, 1, 1, 1, 'Fankriss the Unyielding - Scaled Sand Reaver Leggings'),
(15510, 21652, 0, 0, 0, 1, 1, 1, 1, 'Fankriss the Unyielding - Silithid Carapace Chestguard'),
(15510, 21663, 0, 0, 0, 1, 1, 1, 1, 'Fankriss the Unyielding - Robes of the Guardian Saint'),
(15510, 21664, 0, 0, 0, 1, 1, 1, 1, 'Fankriss the Unyielding - Barbed Choker'),
(15510, 21665, 0, 0, 0, 1, 1, 1, 1, 'Fankriss the Unyielding - Mantle of Wicked Revenge'),
(15510, 22396, 0, 0, 0, 1, 2, 1, 1, 'Fankriss the Unyielding - Totem of Life'),
(15510, 22402, 0, 0, 0, 1, 2, 1, 1, 'Fankriss the Unyielding - Libram of Grace');

-- Princess Huhuran
UPDATE `creature_loot_template` SET `Chance`=0 WHERE `entry`=15509 AND `item` BETWEEN 21616 AND 21621;

-- Twin Emperors
UPDATE `creature_loot_template` SET `Chance`=6.5 WHERE `entry` IN (15275,15276) AND `item` IN (20726,20735);
UPDATE `creature_loot_template` SET `Chance`=0 WHERE `entry` IN (15275,15276) AND `item` IN (21604,21605,21606,21607,21608,21609,21679,21597,21598,21599,21600,21601,21602);

-- C'Thun
DELETE FROM `reference_loot_template` WHERE `Entry`=34049;
DELETE FROM `creature_loot_template` WHERE (`Entry` = 15727) AND (`Item` IN (34049, 21579, 21126, 21134, 21581, 21582, 21583, 21585, 21586, 21596, 21839, 22730, 22731, 22732));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(15727, 21579, 0, 20, 0, 1, 0, 1, 1, 'C\'Thun - Vanquished Tentacle of C\'Thun'),
(15727, 21126, 0, 8, 0, 1, 1, 1, 1, 'C\'Thun - Death\'s Sting'),
(15727, 21134, 0, 8, 0, 1, 2, 1, 1, 'C\'Thun -  Dark Edge of Insanity'),
(15727, 21581, 0, 0, 0, 1, 2, 1, 1, 'C\'Thun - Gauntlets of Annihilation'),
(15727, 21582, 0, 0, 0, 1, 2, 1, 1, 'C\'Thun - Grasp of the Old God'),
(15727, 21583, 0, 0, 0, 1, 2, 1, 1, 'C\'Thun - Cloak of Clarity'),
(15727, 21585, 0, 0, 0, 1, 1, 1, 1, 'C\'Thun - Dark Storm Gauntlets'),
(15727, 21586, 0, 0, 0, 1, 1, 1, 1, 'C\'Thun - Belt of Never-ending Agony'),
(15727, 21596, 0, 0, 0, 1, 1, 1, 1, 'C\'Thun - Ring of the Godslayer'),
(15727, 21839, 0, 8, 0, 1, 2, 1, 1, 'C\'Thun - Scepter of the False Prophet'),
(15727, 22730, 0, 0, 0, 1, 1, 1, 1, 'C\'Thun - Eyestalk Waist Cord'),
(15727, 22731, 0, 0, 0, 1, 1, 1, 1, 'C\'Thun - Cloak of the Devoured'),
(15727, 22732, 0, 0, 0, 1, 2, 1, 1, 'C\'Thun - Mark of C\'Thun');

-- Imperial Qiraji items and Recipes
DELETE FROM `reference_loot_template` WHERE `Entry`=34045 AND `Item` IN (21232, 21237);
DELETE FROM `reference_loot_template` WHERE `Entry`=34046 AND `Item` IN (21232, 21237);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Chance`, `GroupId`, `Comment`) VALUES
(34046, 21232, 0, 1, 'Imperial Qiraji Armaments'),
(34046, 21237, 0, 1, 'Imperial Qiraji Regalia');

DELETE FROM `creature_loot_template` WHERE `Reference` IN (34045, 34046);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(15263, 34045, 34045, 7, 0, 1, 0, 1, 1, 'The Prophet Skeram - Reference Table'),
(15516, 34045, 34045, 7, 0, 1, 0, 1, 1, 'Battleguard Sartura - Reference Table'),
(15516, 34046, 34046, 8, 0, 1, 0, 1, 1, 'Battleguard Sartura - Reference Table'),
(15544, 34045, 34045, 7, 0, 1, 0, 1, 1, 'Vem - Reference Table'),
(15544, 34046, 34046, 8, 0, 1, 0, 1, 1, 'Vem - Reference Table'),
(15543, 34045, 34045, 7, 0, 1, 0, 1, 1, 'Princess Yauj - Reference Table'),
(15543, 34046, 34046, 8, 0, 1, 0, 1, 1, 'Princess Yauj - Reference Table'),
(15511, 34045, 34045, 7, 0, 1, 0, 1, 1, 'Lord Kri - Reference Table'),
(15511, 34046, 34046, 8, 0, 1, 0, 1, 1, 'Lord Kri - Reference Table'),
(15510, 34045, 34045, 7, 0, 1, 0, 1, 1, 'Fankriss the Unyielding - Reference Table'),
(15510, 34046, 34046, 8, 0, 1, 0, 1, 1, 'Fankriss the Unyielding - Reference Table'),
(15299, 34045, 34045, 7, 0, 1, 0, 1, 1, 'Viscidus - Reference Table'),
(15299, 34046, 34046, 8, 0, 1, 0, 1, 1, 'Viscidus - Reference Table'),
(15509, 34045, 34045, 7, 0, 1, 0, 1, 1, 'Princess Huhuran - Reference Table'),
(15509, 34046, 34046, 8, 0, 1, 0, 1, 1, 'Princess Huhuran - Reference Table'),
(15275, 34045, 34045, 7, 0, 1, 0, 1, 1, 'Emperor Vek\'nilash - Reference Table'),
(15275, 34046, 34046, 8, 0, 1, 0, 1, 1, 'Emperor Vek\'nilash - Reference Table'),
(15276, 34045, 34045, 7, 0, 1, 0, 1, 1, 'Emperor Vek\'lor - Reference Table'),
(15276, 34046, 34046, 8, 0, 1, 0, 1, 1, 'Emperor Vek\'lor - Reference Table'),
(15517, 34045, 34045, 7, 0, 1, 0, 1, 1, 'Ouro - Reference Table'),
(15517, 34046, 34046, 8, 0, 1, 0, 1, 1, 'Ouro - Reference Table'),
(15727, 34045, 34045, 7, 0, 1, 0, 1, 1, 'C\'Thun - Reference Table'),
(15727, 34046, 34046, 8, 0, 1, 0, 1, 1, 'C\'Thun - Reference Table');
