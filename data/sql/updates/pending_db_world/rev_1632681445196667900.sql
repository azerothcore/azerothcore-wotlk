INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632681445196667900');

DELETE FROM `gameobject` WHERE (`id` = 2046) AND (`guid` IN (8699));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(8699, 2046, 0, 0, 0, 1, 1, -807.73, -3595.466797, 76.099289, 2.67, 0, 0, 0, 0, 60, 100, 1, '', 0);
