-- DB update 2023_10_10_08 -> 2023_10_10_09
--
DELETE FROM `gameobject` WHERE `guid` IN (9266,9268,9270,9272,9273,9274);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(9266, 2040, 1, 405, 598, 1, 1, -1774, 2968.79, 37.432, 4.232, 0, 0, 0, 0, 2700, 100, 1, '', 0, NULL),
(9268, 2040, 1, 405, 598, 1, 1, -1778, 2997.54, 35.715, 4.76, 0, 0, 0, 0, 2700, 100, 1, '', 0, NULL),
(9270, 2040, 1, 405, 598, 1, 1, -1765, 2986.9, 40.316, 5.803, 0, 0, 0, 0, 2700, 100, 1, '', 0, NULL),
(9272, 1735, 1, 405, 598, 1, 1, -1774, 2968.79, 37.432, 4.232, 0, 0, 0, 0, 2700, 100, 1, '', 0, NULL),
(9273, 1735, 1, 405, 598, 1, 1, -1778, 2997.54, 35.715, 4.76, 0, 0, 0, 0, 2700, 100, 1, '', 0, NULL),
(9274, 1735, 1, 405, 598, 1, 1, -1765, 2986.9, 40.316, 5.803, 0, 0, 0, 0, 2700, 100, 1, '', 0, NULL);

DELETE FROM `pool_template` WHERE `entry` = 11699;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(11699, 1, 'Desolace Mithril Deposit Pool');

DELETE FROM `pool_gameobject` WHERE `guid` IN (9256,9257,9258,9266,9268,9270,9272,9273,9274);
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(9256, 11699, 3.3, 'Spawn Point 1 - Truesilver'),
(9266, 11699, 0, 'Spawn Point 1 - Mithril'),
(9272, 11699, 8.3, 'Spawn Point 1 - Iron'),
(9257, 11699, 3.3, 'Spawn Point 2 - Truesilver'),
(9268, 11699, 0, 'Spawn Point 2 - Mithril'),
(9273, 11699, 8.3, 'Spawn Point 2 - Iron'),
(9258, 11699, 3.3, 'Spawn Point 3 - Truesilver'),
(9270, 11699, 0, 'Spawn Point 3 - Mithril'),
(9274, 11699, 8.3, 'Spawn Point 3 - Iron');
