--
DELETE FROM `gameobject` WHERE `guid` IN (99829, 99830, 99831);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`)
VALUES
(99829, 188019, 571, 0, 0, 1, 1, 3391, 5137, 13, 1.8, 0, 0, 0, 0, 25, 0, 1, "", 0, NULL),
(99830, 188019, 571, 0, 0, 1, 1, 3739, 5047, -0.77, 2.18, 0, 0, 0, 0, 25, 0, 1, "", 0, NULL),
(99831, 188019, 571, 0, 0, 1, 1, 3517, 5016, -1, 2.25, 0, 0, 0, 0, 25, 0, 1, "", 0, NULL);
