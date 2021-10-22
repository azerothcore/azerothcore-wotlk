INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634737924283682006');

-- Deletes Goldthorn from 370 NPCs not listed below
DELETE FROM `creature_loot_template` WHERE `item` = 3821 AND `entry` NOT IN (1081, 1812, 5354, 5481, 5485, 5490, 6509, 6510, 6511, 6512, 6517, 6518, 6519, 6527, 7100, 7101, 7139, 7584, 8384, 11462, 12219, 12220, 12223, 12224, 13022, 13141, 13142);
