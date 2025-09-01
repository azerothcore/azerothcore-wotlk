-- DB update 2023_11_18_05 -> 2023_11_18_06
-- Update gameobject 187936 'Alliance Bonfire' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` = 187936) AND (`guid` IN (76343));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(76343, 187936, 1, 0, 0, 1, 1, 9778.640625, 1019.3812255859375, 1299.7938232421875, 0.261798173189163208, 0, 0, 0.130525588989257812, 0.991444945335388183, 120, 255, 1, "", 50063, NULL);

DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 1) AND (`guid` IN (76343));
INSERT INTO `game_event_gameobject` (`eventEntry`,`guid`) VALUES
(1, 76343);
