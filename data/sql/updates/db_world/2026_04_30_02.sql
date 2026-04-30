-- DB update 2026_04_30_01 -> 2026_04_30_02
--
DELETE FROM `gameobject` WHERE (`id` = 18901) AND (`guid` IN (34006));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(34006, 18901, 33, 0, 0, 1, 1, -249.22014, 2123.1018, 82.80518, 6.0923543, -0.1318922, -0.6946964, -0.1318922, 0.69469833, 0, 100, 1, '', 43400, NULL);

DELETE FROM `gameobject` WHERE (`id` = 18900) AND (`guid` IN (32442));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(32442, 18900, 33, 0, 0, 1, 1, -252.69586, 2114.2246, 82.80518, 6.0923543, -0.1318922, -0.6946964, -0.1318922, 0.69469833, 0, 100, 1, '', 43400, NULL);

DELETE FROM `gameobject` WHERE (`id` = 101811) AND (`guid` IN (32444));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(32444, 101811, 33, 0, 0, 1, 1, -245.59846, 2132.319, 82.80518, 6.0923543, -0.1318922, -0.6946964, -0.1318922, 0.69469833, 0, 100, 1, '', 43400, NULL);

DELETE FROM `gameobject_addon` WHERE `guid` IN (32442, 34006, 32444);
INSERT INTO `gameobject_addon` (`guid`, `parent_rotation0`, `parent_rotation1`, `parent_rotation2`, `parent_rotation3`, `invisibilityType`, `invisibilityValue`) VALUES
(32442, 0, 0, -0.82658964, 0.56280506, 0, 0),
(34006, 0, 0, -0.82658964, 0.56280506, 0, 0),
(32444, 0, 0, -0.82658964, 0.56280506, 0, 0);
