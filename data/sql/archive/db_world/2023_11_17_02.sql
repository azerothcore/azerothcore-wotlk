-- DB update 2023_11_17_01 -> 2023_11_17_02
-- Update gameobject 187559 'Horde Bonfire' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` = 187559) AND (`guid` IN (76320));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(76320, 187559, 0, 0, 0, 1, 1, 587.05645751953125, 1365.0179443359375, 90.47782135009765625, 2.652894020080566406, 0, 0, 0.970294952392578125, 0.241925001144409179, 120, 255, 1, "", 50063, NULL);

DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 1) AND (`guid` IN (76320));
INSERT INTO `game_event_gameobject` (`eventEntry`,`guid`) VALUES
(1, 76320);
