INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635252935230504905');

-- Removes Fadeleaf from 295 NPCs not listed below
DELETE FROM `creature_loot_template` WHERE `item` = 3818 AND `entry` NOT IN (764, 765, 766, 940, 1812, 2931, 4382, 4385, 4386, 4387, 5481, 5485, 5490, 6509, 6510, 6511, 6512, 6517, 6518, 6519, 6527, 7100, 7101, 7104, 7139, 7584, 8384, 11462, 12219, 12220, 12223, 12224, 12836, 13022, 13142, 14231, 14448);

-- Removes lootIDs from Samantha Swifthoof and Watcher Biggs
UPDATE `creature_template` SET `lootid` = 0 WHERE `Entry` IN (5476, 11748);
