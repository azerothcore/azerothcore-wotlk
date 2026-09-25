-- DB update 2025_03_11_00 -> 2025_03_11_01

-- Add RLT for Pendants
DELETE FROM `reference_loot_template` WHERE (`Entry`= 34081) AND (`Item` IN (35292, 35291, 35290));
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
('34081', '35292', '0', '0', '0', '1', '1', '1', '1', 'Sin\'dorei Pendant of Triumph'),
('34081', '35291', '0', '0', '0', '1', '1', '1', '1', 'Sin\'dorei Pendant of Salvation'),
('34081', '35290', '0', '0', '0', '1', '1', '1', '1', 'Sin\'dorei Pendant of Conquest');

-- Add Sunglow Vest into Entropius RLT
DELETE FROM `reference_loot_template` WHERE (`Entry` = 34095) AND (`Item` IN (34212));
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
('34095', '34212', '0', '0', '0', '1', '1', '1', '1', 'Sunglow Vest');

-- Add two items into Sacrolash/Alythes RLT.
DELETE FROM `reference_loot_template` WHERE (`Entry` = 34085) AND (`Item` IN (34209, 34212));
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
('34085', '34209', '0', '0', '0', '1', '1', '1', '1', 'Spaulders of Reclamation'),
('34085', '34212', '0', '0', '0', '1', '1', '1', '1', 'Sunglow Vest');

-- Set loot (Alythess)
DELETE FROM `creature_loot_template` WHERE (`Entry` = 25166) AND (`Item` IN (34081));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(25166, 34081, 34081, 100, 0, 1, 1, 1, 1, 'Grand Warlock Alythess - (ReferenceTable 2)');

-- Set loot (Sacrolash)
DELETE FROM `creature_loot_template` WHERE (`Entry` = 25165) AND (`Item` IN (34085, 34664, 34081));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(25165, 34085, 34085, 100, 0, 1, 1, 4, 4, 'Lady Sacrolash - (ReferenceTable)'),
(25165, 34664, 0, 100, 0, 1, 0, 4, 4, 'Lady Sacrolash - Sunmote'),
(25165, 34081, 34081, 100, 0, 1, 1, 1, 1, 'Lady Sacrolash - (ReferenceTable 2)');
