-- DB update 2023_11_18_10 -> 2023_11_18_11
-- Update gameobject 187931 'Alliance Bonfire' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` = 187931) AND (`guid` IN (76316));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(76316, 187931, 0, 0, 0, 1, 1, -604.1475830078125, -545.8125, 36.57901382446289062, 0.698131442070007324, 0, 0, 0.342020034790039062, 0.939692676067352294, 120, 255, 1, "", 50063, NULL);

DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 1) AND (`guid` IN (76316));
INSERT INTO `game_event_gameobject` (`eventEntry`,`guid`) VALUES
(1, 76316);
