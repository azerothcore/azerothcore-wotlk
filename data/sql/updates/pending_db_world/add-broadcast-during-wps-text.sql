--
DELETE FROM `waypoint_scripts` WHERE `guid` IN (1006, 1007, 1008);
INSERT INTO `waypoint_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`, `guid`) VALUES
(1006, 0, 0, 0, 0, 22042, 0, 0, 0, 0, 1006),
(1007, 0, 0, 0, 0, 22045, 0, 0, 0, 0, 1007),
(1008, 0, 0, 0, 0, 22043, 0, 0, 0, 0, 1008);
