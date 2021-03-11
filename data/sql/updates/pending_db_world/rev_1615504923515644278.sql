INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1615504923515644278');

DELETE FROM `gameobject` WHERE (`id` = 2008) AND (`guid` IN (17154));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(17154, 2008, 0, 0, 0, 1, 1, -19.5537, -935.304, 58.0971, 2.6529, -0.046553, 0.011607, 0.969178, 0.241643, 7200, 100, 1, '', 0);

