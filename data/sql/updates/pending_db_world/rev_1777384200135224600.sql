--
DELETE FROM `gameobject` WHERE (`id` = 18901) AND (`guid` IN (34006));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(34006, 18901, 33, 0, 0, 1, 1, -249.213, 2123.05, 82.5795, 4.71239, -0.131892, -0.694697, -0.131892, 0.694697, 0, 100, 1, '', 0, NULL);

DELETE FROM `gameobject` WHERE (`id` = 18900) AND (`guid` IN (32442));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(32442, 18900, 33, 0, 0, 1, 1, -252.834, 2113.87, 82.5795, 4.71239, -0.131892, -0.694697, -0.131892, 0.694697, 0, 100, 1, '', 0, NULL);
