INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1613357478020500900');

/* Move Copper Vein GUID 4788 to avoid being spawned inside of a map object
*/

DELETE FROM `gameobject` WHERE (`id` = 1731) AND (`guid` IN (4788));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(4788, 1731, 1, 0, 0, 1, 1, 1125.928345, -4498.002441, 20.325047, 4.777278, 0, 0, 0.704938, 0.709268, 900, 100, 1, '', 0);
