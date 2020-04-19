INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1587299483794804200');

DELETE FROM `gameobject` WHERE `guid` = 56732 AND `id` = 186662;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES 
(56732, 186662, 571, 0, 0, 1, 1, 792.891, -5149.93, -82.3544, 2.11791, -0, -0, -0.871844, -0.489783, 5, 100, 1, '', 0);
