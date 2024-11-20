-- DB update 2023_11_16_10 -> 2023_11_17_00
-- Update gameobject 188352 'Flame of Shattrath' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` = 188352) AND (`guid` IN (54943));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(54943, 188352, 530, 0, 0, 1, 1, -1747.8482666015625, 5326.28515625, -12.428135871887207, 3.263772249221801757, 0, 0, -0.99813461303710937, 0.061051756143569946, 120, 255, 1, "", 50063, NULL);

DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 1) AND (`guid` IN (54943));
INSERT INTO `game_event_gameobject` (`eventEntry`,`guid`) VALUES
(1, 54943);
