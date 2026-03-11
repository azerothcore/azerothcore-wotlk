-- DB update 2024_12_07_02 -> 2024_12_07_03
-- Update gameobject 'Boss Fight Altar' with sniffed values
-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (180875))
AND (`guid` IN (160, 161));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(160, 180875, 1, 0, 0, 1, 1, 7531.74462890625, -2851.106689453125, 457.817230224609375, 2.408554315567016601, 0, 0, 0.933580398559570312, 0.358368009328842163, 120, 255, 1, "", 47720, NULL),
(161, 180875, 1, 0, 0, 1, 1, 7561.2021484375, -2872.201171875, 459.990631103515625, 2.583080768585205078, 0, 0, 0.961260795593261718, 0.275640487670898437, 120, 255, 1, "", 47720, NULL);

-- enable all spawns for eventEntry 7
DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 7)
AND (`guid` IN (SELECT `guid` FROM `gameobject` WHERE `id` IN (180875)));
INSERT INTO `game_event_gameobject` (SELECT 7, `guid` FROM `gameobject` WHERE `id` IN (180875));
