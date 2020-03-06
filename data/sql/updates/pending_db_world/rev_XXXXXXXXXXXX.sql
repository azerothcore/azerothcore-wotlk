INSERT INTO `version_db_world` (`sql_rev`) VALUES ('XXXXXXXXXXXX');

DELETE FROM `gameobject_loot_template` WHERE `entry` IN (11104); -- Secret Safe
INSERT INTO `gameobject_loot_template` (`entry`, `item`, `chance`, `questrequired`,  `groupid`, `mincount`, `maxcount`) VALUES
(11104, 22205, 25, 0, 1, 1, 1),
(11104, 22255, 25, 0, 1, 1, 1),
(11104, 22256, 25, 0, 1, 1, 1),
(11104, 22254, 25, 0, 1, 1, 1),
(11104, 11309, 100, 1, 1, 1, 1);
