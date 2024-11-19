-- DB update 2023_11_18_07 -> 2023_11_18_08
-- Update gameobject 187920 'Alliance Bonfire' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` = 187920) AND (`guid` IN (76302));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(76302, 187920, 0, 0, 0, 1, 1, -10951.494140625, -3218.10009765625, 41.34749984741210937, 1.919861555099487304, 0, 0, 0.819151878356933593, 0.573576688766479492, 120, 255, 1, "", 50063, NULL);

DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 1) AND (`guid` IN (76302));
INSERT INTO `game_event_gameobject` (`eventEntry`,`guid`) VALUES
(1, 76302);
