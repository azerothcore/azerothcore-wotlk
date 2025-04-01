-- DB update 2024_12_07_00 -> 2024_12_07_01
-- Update gameobject 'Starsong Scroll' with sniffed values
-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (180910))
AND (`guid` IN (34));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(34, 180910, 1, 0, 0, 1, 1, 7946.6806640625, -2621.326416015625, 494.192718505859375, 5.131268978118896484, 0, 0, -0.54463863372802734, 0.838670849800109863, 120, 255, 1, "", 47720, NULL);

-- enable all spawns for eventEntry 7
DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 7)
AND (`guid` IN (SELECT `guid` FROM `gameobject` WHERE `id` IN (180910)));
INSERT INTO `game_event_gameobject` (SELECT 7, `guid` FROM `gameobject` WHERE `id` IN (180910));
