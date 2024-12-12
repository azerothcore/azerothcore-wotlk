-- DB update 2023_11_18_08 -> 2023_11_18_09
-- Update gameobject 187921 'Alliance Bonfire' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` = 187921) AND (`guid` IN (76350));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(76350, 187921, 530, 0, 0, 1, 1, -2247.220703125, -11898.091796875, 26.92943954467773437, 1.675513744354248046, 0, 0, 0.743144035339355468, 0.669131457805633544, 120, 255, 1, "", 50063, NULL);

DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 1) AND (`guid` IN (76350));
INSERT INTO `game_event_gameobject` (`eventEntry`,`guid`) VALUES
(1, 76350);
