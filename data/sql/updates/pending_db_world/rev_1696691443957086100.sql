--
DELETE FROM `gameobject` WHERE `guid` IN (9266,9268,9270,9272,9273,9274);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(9266, 2040, 1, 405, 598, 1, 1, -1774, 2968.79, 37.432, 4.232, 0, 0, 0, 0, 2700, 100, 1, '', 0, NULL),
(9268, 2040, 1, 405, 598, 1, 1, -1778, 2997.54, 35.715, 4.76, 0, 0, 0, 0, 2700, 100, 1, '', 0, NULL),
(9270, 2040, 1, 405, 598, 1, 1, -1765, 2986.9, 40.316, 5.803, 0, 0, 0, 0, 2700, 100, 1, '', 0, NULL),
(9272, 1735, 1, 405, 598, 1, 1, -1774, 2968.79, 37.432, 4.232, 0, 0, 0, 0, 2700, 100, 1, '', 0, NULL),
(9273, 1735, 1, 405, 598, 1, 1, -1778, 2997.54, 35.715, 4.76, 0, 0, 0, 0, 2700, 100, 1, '', 0, NULL),
(9274, 1735, 1, 405, 598, 1, 1, -1765, 2986.9, 40.316, 5.803, 0, 0, 0, 0, 2700, 100, 1, '', 0, NULL);

DELETE FROM `pool_template` WHERE `entry` IN (11699,11706,11707,11708);
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(11699, 1, 'Spawn Point 1 - Desolace'),
(11706, 1, 'Spawn Point 2 - Desolace'),
(11707, 1, 'Spawn Point 3 - Desolace'),
(11708, 1, 'Desolace Mithril Deposit Pool of Pools 1');

DELETE FROM `pool_gameobject` WHERE `guid` IN (9256,9257,9258,9266,9268,9270,9272,9273,9274);
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(9256, 11699, 10, 'Spawn Point 1 - Truesilver'),
(9266, 11699, 0, 'Spawn Point 1 - Mithril'),
(9272, 11699, 25, 'Spawn Point 1 - Iron'),
(9257, 11706, 10, 'Spawn Point 2 - Truesilver'),
(9268, 11706, 0, 'Spawn Point 2 - Mithril'),
(9273, 11706, 25, 'Spawn Point 2 - Iron'),
(9258, 11707, 10, 'Spawn Point 3 - Truesilver'),
(9270, 11707, 0, 'Spawn Point 3 - Mithril'),
(9274, 11707, 25, 'Spawn Point 3 - Iron');

DELETE FROM `pool_pool` WHERE `mother_pool` = 11708;
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES
(11699, 11708, 0, 'Desolace - Mithril Deposit - Group 1'),
(11706, 11708, 0, 'Desolace - Mithril Deposit - Group 1'),
(11707, 11708, 0, 'Desolace - Mithril Deposit - Group 1');
