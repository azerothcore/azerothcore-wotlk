INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1583690478008671900');

-- Set logic ID number
UPDATE `gameobject_template` SET `Data1` = '161495' WHERE `entry` = '161495';

-- Delete old entry and add new one with correct ID
DELETE FROM `gameobject_loot_template` WHERE `entry` IN (11104,161495); -- Secret Safe
INSERT INTO `gameobject_loot_template` (`entry`, `item`, `chance`, `questrequired`,  `groupid`, `mincount`, `maxcount`) VALUES
(161495, 22205, 0, 0, 1, 1, 1),
(161495, 22255, 0, 0, 1, 1, 1),
(161495, 22256, 0, 0, 1, 1, 1),
(161495, 22254, 0, 0, 1, 1, 1),
(161495, 11309, 100, 1, 0, 1, 1);
