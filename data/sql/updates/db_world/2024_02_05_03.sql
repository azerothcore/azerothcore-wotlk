-- DB update 2024_02_05_02 -> 2024_02_05_03
-- Update 'Shaman Bonfire Bunny' spawns with sniffed values
DELETE FROM `creature` WHERE (`id1` IN (25971, 25972, 25973)) AND (`guid` IN (245810, 245811, 245812));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
-- 'Shaman Bonfire Bunny 000'
(245810, 25971, 547, 3, 1, 0, -143.17193603515625, -147.680130004882812, -3.16113066673278808, 4.852015495300292968, 7200, 0, 0, 0, 0, 0, "", 50172, 1, NULL),
-- 'Shaman Bonfire Bunny 001'
(245811, 25972, 547, 3, 1, 0, -134.30364990234375, -145.780303955078125, -1.70331764221191406, 4.677482128143310546, 7200, 0, 0, 0, 0, 0, "", 50172, 1, NULL),
-- 'Shaman Bonfire Bunny 002'
(245812, 25973, 547, 3, 1, 0, -125.035713195800781, -144.20654296875, -1.91659557819366455, 4.991641521453857421, 7200, 0, 0, 0, 0, 0, "", 50172, 1, NULL);

-- enable all spawns for eventEntry 1
DELETE FROM `game_event_creature` WHERE (`eventEntry` = 1) AND (`guid` IN (SELECT `guid` FROM `creature` WHERE `id1` IN (25971, 25972, 25973)));
INSERT INTO `game_event_creature` (SELECT 1, `guid` FROM `creature` WHERE `id1` IN (25971, 25972, 25973));
