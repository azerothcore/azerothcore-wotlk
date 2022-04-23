INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1650360263328185762');

DELETE FROM `gameobject` WHERE (`id` = 180323) AND (`guid` IN (28668));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(28668, 180323, 309, 1977, 1977, 1, 1, -11916.8, -1221.22, 92.5045, -1.5708, 0, 0, -0.707107, 0.707107, 600, 100, 1, '', 0);
