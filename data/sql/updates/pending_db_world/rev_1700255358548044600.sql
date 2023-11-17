-- Update gameobject 187935 'Alliance Bonfire' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` = 187935) AND (`guid` IN (76345));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(76345, 187935, 530, 0, 0, 1, 1, -3943.538330078125, 2049.31396484375, 95.06470489501953125, 6.09120035171508789, 0, 0, -0.09584522247314453, 0.995396256446838378, 120, 255, 1, "", 50063, NULL);

DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 1) AND (`guid` IN (76345));
INSERT INTO `game_event_gameobject` (`eventEntry`,`guid`) VALUES
(1, 76345);
