DELETE FROM `gameobject` WHERE (`id` = 187929);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(164905, 187929, 1, 0, 0, 1, 1, -4412.02, 3480.24, 12.6312, 6.12709, 0, 0, 0.0779684, -0.996956, 300, 0, 1, '', 0);

DELETE FROM `game_event_gameobject` WHERE `eventEntry` = '1' AND `guid` = '242532';
INSERT INTO `game_event_gameobject` (`eventEntry`, `guid`) VALUES ('1', '164905'); 
