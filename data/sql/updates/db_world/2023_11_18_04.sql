-- DB update 2023_11_18_03 -> 2023_11_18_04
-- Update gameobject 187937 'Alliance Bonfire' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` = 187937) AND (`guid` IN (76347));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(76347, 187937, 530, 0, 0, 1, 1, -2999.860595703125, 4155.49853515625, 4.566021919250488281, 1.082102894783020019, 0, 0, 0.51503753662109375, 0.857167601585388183, 120, 255, 1, "", 50063, NULL);

DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 1) AND (`guid` IN (76347));
INSERT INTO `game_event_gameobject` (`eventEntry`,`guid`) VALUES
(1, 76347);
