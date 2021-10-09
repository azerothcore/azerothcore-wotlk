INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633784351138842832');

-- Removes invalid Purple Lotus drops from various NPCs
explain DELETE FROM `creature_loot_template` WHERE `item` = 8831 AND `entry` NOT IN (12219, 6510, 6509, 6511, 6512, 12223, 12224, 12220, 5881, 8384, 13141, 13142, 5490, 7139, 14448, 1812, 6517, 6527, 6519, 6518, 5481, 5485, 7584, 7100, 7101, 11462, 13022);

