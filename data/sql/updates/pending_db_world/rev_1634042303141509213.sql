INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634042303141509213');

-- Removes invalid Firebloom drops from various NPCs
DELETE FROM `creature_loot_template` WHERE `item` = 4625 AND `entry` NOT IN (1812, 1851, 5481, 5485, 5490, 5881, 6509, 6510, 6511, 6512, 6517, 6518, 
6519, 6527, 7100, 7101, 7139, 7584, 8384, 11462, 12219, 12220, 12223, 12224, 13022, 13141, 13142);
