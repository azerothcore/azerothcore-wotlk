INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633732567546468906');

#fix herb at entrance of the building #8355
DELETE FROM `gameobject` WHERE (`id` = 1622) AND (`guid` IN (3764));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(3764, 1622, 0, 0, 0, 1, 1, -2644.78, -2362.86, 97.341, 2.909, 0, 0, 0, 0, 60, 100, 1, '', 0);
