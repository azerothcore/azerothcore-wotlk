-- DB update 2026_05_18_00 -> 2026_05_18_01

-- Update 15066 spawntime (it must be instant), add two new spawn points and set random in radius.
DELETE FROM `creature` WHERE (`id1` = 3467);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(15066, 3467, 0, 0, 1, 0, 0, 1, 1, 1, -1571.79, -3884.28, 16.2173, 3.83286, 1, 5, 0, 356, 0, 1, 0, 0, 0, '67511', 0, 0, NULL),
(15215, 3467, 0, 0, 1, 0, 0, 1, 1, 1, -1748.25, -3721.78, 16.2173, 14.1181, 1, 5, 0, 356, 0, 1, 0, 0, 0, '67511', 0, 0, NULL),
(15217, 3467, 0, 0, 1, 0, 0, 1, 1, 1, -1706.97, -3818.9, 13.1778, 4.88414, 1, 5, 0, 356, 0, 1, 0, 0, 0, '67511', 0, 0, NULL);

-- Delete Baron Longshore Creature Addon
DELETE FROM `creature_addon` WHERE (`guid` IN (15066));

-- Set Baron Longshore template addon.
DELETE FROM `creature_template_addon` WHERE (`entry` = 3467);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(3467, 0, 0, 0, 1, 0, 0, '');

-- Set Baron Longshore Pool Template
DELETE FROM `pool_template` WHERE (`entry` IN (144));
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(144, 1, 'Baron Longshore');

-- Link Baron Longshore Spawn Points to Pool Entry.
DELETE FROM `pool_creature` WHERE (`guid` IN (15066, 15215, 15217));
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(15066, 144, 0, 'Baron Longshore 1'),
(15215, 144, 0, 'Baron Longshore 2'),
(15217, 144, 0, 'Baron Longshore 3');
