INSERT INTO `version_db_world` (`sql_rev`) VALUES ('XXXXXXXXXXXX');

DELETE FROM `gameobject_loot_template` WHERE `entry` IN (161495); -- Secret Safe
INSERT INTO `gameobject_loot_template` (`entry`, `item`, `chance`, `questrequired`,  `groupid`, `mincount`, `maxcount`) VALUES
(161495, 22205, 25, 0, 1, 1, 1),
(161495, 22255, 25, 0, 1, 1, 1),
(161495, 22256, 25, 0, 1, 1, 1),
(161495, 22254, 25, 0, 1, 1, 1),
(161495, 11309, 100, 1, 1, 1, 1);
