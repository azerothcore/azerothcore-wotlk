-- DB update 2023_11_18_04 -> 2023_11_18_05
-- Update gameobject 187917 'Alliance Bonfire' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` = 187917) AND (`guid` IN (76344));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(76344, 187917, 530, 0, 0, 1, 1, -4223.84326171875, -12318.365234375, 2.476949930191040039, 2.932138919830322265, 0, 0, 0.994521141052246093, 0.104535527527332305, 120, 255, 1, "", 50063, NULL);

DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 1) AND (`guid` IN (76344));
INSERT INTO `game_event_gameobject` (`eventEntry`,`guid`) VALUES
(1, 76344);
