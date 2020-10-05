INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601868704763174600');

DELETE FROM `gameobject` WHERE (`id` = 182947) AND (`guid` IN (23860));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(23860, 182947, 555, 0, 0, 3, 1, -267.122, -263.761, 14.1797, -2.93215, 0, 0, 0.994522, -0.104529, 43200, 100, 1, '', 0);