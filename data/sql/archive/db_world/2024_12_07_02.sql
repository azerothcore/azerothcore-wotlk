-- DB update 2024_12_07_01 -> 2024_12_07_02
-- Update gameobject 'DwarvenTableSmall' with sniffed values
-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (180884))
AND (`guid` IN (36));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(36, 180884, 0, 0, 0, 1, 1, -4643.95556640625, -952.7752685546875, 501.660858154296875, 1.675513744354248046, 0, 0, 0.743144035339355468, 0.669131457805633544, 120, 255, 1, "", 47720, NULL);

-- enable all spawns for eventEntry 7
DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 7)
AND (`guid` IN (SELECT `guid` FROM `gameobject` WHERE `id` IN (180884)));
INSERT INTO `game_event_gameobject` (SELECT 7, `guid` FROM `gameobject` WHERE `id` IN (180884));
