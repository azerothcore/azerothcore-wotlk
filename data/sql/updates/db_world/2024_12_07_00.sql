-- DB update 2024_12_06_00 -> 2024_12_07_00
-- Update gameobject 'Lucky Red Envelope' with sniffed values
-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (180909))
AND (`guid` IN (165, 166, 167, 168));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(165, 180909, 1, 0, 0, 1, 1, 7946.251953125, -2621.75341796875, 494.15185546875, 6.161012649536132812, 0, 0, -0.06104850769042968, 0.998134791851043701, 120, 255, 1, "", 47720, NULL),
(166, 180909, 1, 0, 0, 1, 1, 7946.6650390625, -2621.123291015625, 494.20648193359375, 2.775068521499633789, 0, 0, 0.983254432678222656, 0.182238012552261352, 120, 255, 1, "", 47720, NULL),
(167, 180909, 1, 0, 0, 1, 1, 7946.77685546875, -2621.55908203125, 494.199432373046875, 3.263772249221801757, 0, 0, -0.99813461303710937, 0.061051756143569946, 120, 255, 1, "", 47720, NULL),
(168, 180909, 1, 0, 0, 1, 1, 7947.23779296875, -2621.350830078125, 494.17816162109375, 3.822272777557373046, 0, 0, -0.94264125823974609, 0.333807557821273803, 120, 255, 1, "", 47720, NULL);

-- enable all spawns for eventEntry 7
DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 7)
AND (`guid` IN (SELECT `guid` FROM `gameobject` WHERE `id` IN (180909)));
INSERT INTO `game_event_gameobject` (SELECT 7, `guid` FROM `gameobject` WHERE `id` IN (180909));
