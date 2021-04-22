INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619117628785609042');

DELETE FROM `gameobject` WHERE (`id` = 181918) AND (`guid` IN (22375));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(22375, 181918, 530, 0, 0, 1, 1, -2020.59, -11879.4, 45.4187, 2.47328, 0, 0, 0.944687, 0.327972, 26, 0, 1, '', 0);

