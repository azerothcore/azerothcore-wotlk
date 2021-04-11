INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1618177302172059302');

DELETE FROM `gameobject` WHERE `id`=2046 AND `guid`=8871;

DELETE FROM `gameobject` WHERE (`id` = 1623) AND (`guid` IN (4214));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(4214, 1623, 0, 0, 0, 1, 1, -581.555237, -2028.706299, 69.566879, 4.984, 0, 0, 0, 0, 60, 100, 1, '', 0);
