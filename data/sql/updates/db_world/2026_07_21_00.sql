-- DB update 2026_07_20_01 -> 2026_07_21_00

-- Add Missing Waypoint (Sniffed).
DELETE FROM `waypoint_data` WHERE `id` = 12889700;
INSERT INTO `waypoint_data` VALUES
(12889700, 1, 2387.85, -5902.72, 109.01, NULL, 0, 0, 0, 0, 0, 100, 0),
(12889700, 2, 2375.1, -5907.97, 108.48, NULL, 0, 0, 0, 0, 0, 100, 0),
(12889700, 3, 2368.94, -5909.22, 107.61, NULL, 0, 0, 0, 0, 0, 100, 0),
(12889700, 4, 2356.44, -5906.22, 105.61, NULL, 0, 0, 0, 0, 0, 100, 0),
(12889700, 5, 2346.94, -5904.22, 104.11, NULL, 0, 0, 0, 0, 0, 100, 0),
(12889700, 6, 2336.87, -5901.97, 101.55, NULL, 0, 0, 0, 0, 0, 100, 0),
(12889700, 7, 2327.17, -5902.61, 98.16, NULL, 0, 0, 0, 0, 0, 100, 0),
(12889700, 8, 2319.57, -5904.3, 95.21, NULL, 0, 0, 0, 0, 0, 100, 0),
(12889700, 9, 2311.32, -5907.05, 91.71, NULL, 0, 0, 0, 0, 0, 100, 0),
(12889700, 10, 2303.66, -5910.16, 87.98, NULL, 0, 0, 0, 0, 0, 100, 0),
(12889700, 11, 2298.06, -5920.62, 81.04, NULL, 0, 0, 0, 0, 0, 100, 0),
(12889700, 12, 2291.1, -5932.64, 71.66, NULL, 0, 0, 0, 0, 0, 100, 0),
(12889700, 13, 2286.46, -5943.81, 64.32, NULL, 0, 0, 0, 0, 0, 100, 0),
(12889700, 14, 2281.71, -5955.31, 57.32, NULL, 0, 0, 0, 0, 0, 100, 0),
(12889700, 15, 2276.51, -5967.19, 51.39, NULL, 0, 0, 0, 0, 0, 100, 0),
(12889700, 16, 2266.45, -5971.84, 46.41, NULL, 0, 0, 0, 0, 0, 100, 0),
(12889700, 17, 2255.95, -5976.84, 40.41, NULL, 0, 0, 0, 0, 0, 100, 0),
(12889700, 18, 2247.58, -5980.87, 35.15, NULL, 0, 0, 0, 0, 0, 100, 0),
(12889700, 19, 2240.51, -5992.78, 29.5, NULL, 0, 0, 0, 0, 0, 100, 0),
(12889700, 20, 2233.01, -6005.53, 20.25, NULL, 0, 0, 0, 0, 0, 100, 0),
(12889700, 21, 2228.16, -6015.24, 12.25, NULL, 0, 0, 0, 0, 0, 100, 0),
(12889700, 22, 2218.33, -6037.6, 6.9, NULL, 0, 0, 0, 0, 0, 100, 0),
(12889700, 23, 2212.45, -6062.62, 6.18, NULL, 0, 0, 0, 0, 0, 100, 0),
(12889700, 24, 2207.75, -6082.03, 3.81, NULL, 0, 0, 0, 0, 0, 100, 0),
(12889700, 25, 2198.39, -6112.08, 1.61, NULL, 0, 0, 0, 0, 0, 100, 0),
(12889700, 26, 2189.55, -6127.57, 2.66, NULL, 0, 0, 0, 0, 0, 100, 0),
(12889700, 27, 2184.3, -6137.07, 3.41, NULL, 0, 0, 0, 0, 0, 100, 0),
(12889700, 28, 2179.45, -6145.61, 1.72, NULL, 0, 0, 0, 0, 0, 100, 0),
(12889700, 29, 2178.81, -6168.32, 0.89, NULL, 0, 0, 0, 0, 0, 100, 0);

-- Set Verified Build for all Scarlet Miners.
UPDATE `creature` SET `VerifiedBuild` = 50664 WHERE (`id` = 28822);

-- Add New Scarlet Miner Spawn Point (Sniffed).
DELETE FROM `creature` WHERE (`id` = 28822) AND (`guid` IN (128897));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `Comment`, `VerifiedBuild`) VALUES
(128897, 28822, 609, 0, 0, 1, 1, 0, 2389.6025, -5901.942, 109.09488, 4.520403, 360, 0, 0, 891, 0, 0, 0, 0, 0, '', 'has guid specific SAI', 50664);

-- Add Mine Car Spawn Points (Sniffed)
DELETE FROM `creature` WHERE (`id` = 28821);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(128902, 28821, 609, 0, 0, 1, 1, 0, 2392.9, -5932.47, 110.954, 2.25148, 600, 0, 0, 42, 0, 0, 0, 0, 0, '', 50664, 0, ''),
(128903, 28821, 609, 0, 0, 1, 1, 0, 2477.86, -5930.89, 116.103, 3.89208, 600, 0, 0, 42, 0, 0, 0, 0, 0, '', 50664, 0, ''),
(128904, 28821, 609, 0, 0, 1, 1, 0, 2431.82, -5884.38, 104.739, 1.43117, 600, 0, 0, 42, 0, 0, 0, 0, 0, '', 50664, 0, ''),
(128905, 28821, 609, 0, 0, 1, 1, 0, 2450.51, -5956.79, 96.0638, 6.17846, 600, 0, 0, 42, 0, 0, 0, 0, 0, '', 50664, 0, ''),
(128906, 28821, 609, 0, 0, 1, 1, 0, 2393.37, -5912.72, 110.304, 2.44346, 600, 0, 0, 42, 0, 0, 0, 0, 0, '', 50664, 0, ''),
(128907, 28821, 609, 0, 0, 1, 1, 0, 2410.78, -5930.6, 113.883, 6.14356, 600, 0, 0, 42, 0, 0, 0, 0, 0, '', 50664, 0, ''),
(128908, 28821, 609, 0, 0, 1, 1, 0, 2418.08, -5919.31, 111.58, 5.77704, 600, 0, 0, 42, 0, 0, 0, 0, 0, '', 50664, 0, ''),
(128909, 28821, 609, 0, 0, 1, 1, 0, 2393.29, -5900.68, 109.435, 1.93731, 600, 0, 0, 42, 0, 0, 0, 0, 0, '', 50664, 0, ''),
(128921, 28821, 609, 0, 0, 1, 1, 0, 2538.37, -5995.51, 103.085, 6.10865, 600, 0, 0, 42, 0, 0, 0, 0, 0, '', 50664, 0, '');

-- Move Row 6 to row 0.
UPDATE `smart_scripts` SET `id` = 0 WHERE (`entryorguid` = 28822) AND (`source_type` = 0) AND (`id` IN (6));

-- Update Personal SAI (Scarlet Miner).
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (-128892, -128893, -128894, -128895, -128896, -128897, -128898, -128899, -128901));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-128892, 0, 1000, 1001, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 10, 128902, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Respawn Closest Creature \'Mine Car\''),
(-128892, 0, 1001, 1002, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52414, 0, 0, 0, 0, 0, 10, 128902, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Cast \'Drag Mine Cart\''),
(-128892, 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 12889200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Start Path 12889200'),
(-128892, 0, 1003, 1004, 109, 0, 100, 0, 0, 12889200, 0, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 10, 128902, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12889200 Finished - Despawn In 2000 ms'),
(-128892, 0, 1004, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12889200 Finished - Despawn In 2000 ms'),
(-128892, 0, 1005, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 10, 128902, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Just Died - Despawn In 1000 ms'),
(-128892, 0, 1006, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52414, 0, 0, 0, 0, 0, 10, 128902, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Evade - Cast \'Drag Mine Cart\''),
(-128893, 0, 1000, 1001, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 10, 128903, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Respawn Closest Creature \'Mine Car\''),
(-128893, 0, 1001, 1002, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52414, 0, 0, 0, 0, 0, 10, 128903, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Cast \'Drag Mine Cart\''),
(-128893, 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 12889300, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Start Path 12889200'),
(-128893, 0, 1003, 1004, 109, 0, 100, 0, 0, 12889300, 0, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 10, 128903, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12889200 Finished - Despawn In 2000 ms'),
(-128893, 0, 1004, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12889200 Finished - Despawn In 2000 ms'),
(-128893, 0, 1005, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 10, 128903, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Just Died - Despawn In 1000 ms'),
(-128893, 0, 1006, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52414, 0, 0, 0, 0, 0, 10, 128903, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Evade - Cast \'Drag Mine Cart\''),
(-128894, 0, 1000, 1001, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 10, 128904, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Respawn Closest Creature \'Mine Car\''),
(-128894, 0, 1001, 1002, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52414, 0, 0, 0, 0, 0, 10, 128904, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Cast \'Drag Mine Cart\''),
(-128894, 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 12889400, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Start Path 12889200'),
(-128894, 0, 1003, 1004, 109, 0, 100, 0, 0, 12889400, 0, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 10, 128904, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12889200 Finished - Despawn In 2000 ms'),
(-128894, 0, 1004, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12889200 Finished - Despawn In 2000 ms'),
(-128894, 0, 1005, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 10, 128904, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Just Died - Despawn In 1000 ms'),
(-128894, 0, 1006, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52414, 0, 0, 0, 0, 0, 10, 128904, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Evade - Cast \'Drag Mine Cart\''),
(-128895, 0, 1000, 1001, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 10, 128905, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Respawn Closest Creature \'Mine Car\''),
(-128895, 0, 1001, 1002, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52414, 0, 0, 0, 0, 0, 10, 128905, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Cast \'Drag Mine Cart\''),
(-128895, 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 12889500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Start Path 12889200'),
(-128895, 0, 1003, 1004, 109, 0, 100, 0, 0, 12889500, 0, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 10, 128905, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12889200 Finished - Despawn In 2000 ms'),
(-128895, 0, 1004, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12889200 Finished - Despawn In 2000 ms'),
(-128895, 0, 1005, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 10, 128905, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Just Died - Despawn In 1000 ms'),
(-128895, 0, 1006, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52414, 0, 0, 0, 0, 0, 10, 128905, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Evade - Cast \'Drag Mine Cart\''),
(-128896, 0, 1000, 1001, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 10, 128906, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Respawn Closest Creature \'Mine Car\''),
(-128896, 0, 1001, 1002, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52414, 0, 0, 0, 0, 0, 10, 128906, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Cast \'Drag Mine Cart\''),
(-128896, 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 12889600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Start Path 12889200'),
(-128896, 0, 1003, 1004, 109, 0, 100, 0, 0, 12889600, 0, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 10, 128906, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12889200 Finished - Despawn In 2000 ms'),
(-128896, 0, 1004, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12889200 Finished - Despawn In 2000 ms'),
(-128896, 0, 1005, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 10, 128906, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Just Died - Despawn In 1000 ms'),
(-128896, 0, 1006, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52414, 0, 0, 0, 0, 0, 10, 128906, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Evade - Cast \'Drag Mine Cart\''),
(-128897, 0, 1000, 1001, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 10, 128909, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Respawn Closest Creature \'Mine Car\''),
(-128897, 0, 1001, 1002, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52414, 0, 0, 0, 0, 0, 10, 128909, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Cast \'Drag Mine Cart\''),
(-128897, 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 12889700, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Start Path 12889200'),
(-128897, 0, 1003, 1004, 109, 0, 100, 0, 0, 12889700, 0, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 10, 128909, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12889200 Finished - Despawn In 2000 ms'),
(-128897, 0, 1004, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12889200 Finished - Despawn In 2000 ms'),
(-128897, 0, 1005, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 10, 128909, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Just Died - Despawn In 1000 ms'),
(-128897, 0, 1006, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52414, 0, 0, 0, 0, 0, 10, 128909, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Evade - Cast \'Drag Mine Cart\''),
(-128898, 0, 1000, 1001, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 10, 128907, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Respawn Closest Creature \'Mine Car\''),
(-128898, 0, 1001, 1002, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52414, 0, 0, 0, 0, 0, 10, 128907, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Cast \'Drag Mine Cart\''),
(-128898, 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 12889800, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Start Path 12889200'),
(-128898, 0, 1003, 1004, 109, 0, 100, 0, 0, 12889800, 0, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 10, 128907, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12889200 Finished - Despawn In 2000 ms'),
(-128898, 0, 1004, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12889200 Finished - Despawn In 2000 ms'),
(-128898, 0, 1005, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 10, 128907, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Just Died - Despawn In 1000 ms'),
(-128898, 0, 1006, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52414, 0, 0, 0, 0, 0, 10, 128907, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Evade - Cast \'Drag Mine Cart\''),
(-128899, 0, 1000, 1001, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 10, 128908, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Respawn Closest Creature \'Mine Car\''),
(-128899, 0, 1001, 1002, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52414, 0, 0, 0, 0, 0, 10, 128908, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Cast \'Drag Mine Cart\''),
(-128899, 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 12889900, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Start Path 12889200'),
(-128899, 0, 1003, 1004, 109, 0, 100, 0, 0, 12889900, 0, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 10, 128908, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12889200 Finished - Despawn In 2000 ms'),
(-128899, 0, 1004, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12889200 Finished - Despawn In 2000 ms'),
(-128899, 0, 1005, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 10, 128908, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Just Died - Despawn In 1000 ms'),
(-128899, 0, 1006, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52414, 0, 0, 0, 0, 0, 10, 128908, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Evade - Cast \'Drag Mine Cart\''),
(-128901, 0, 1000, 1001, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 10, 128921, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Respawn Closest Creature \'Mine Car\''),
(-128901, 0, 1001, 1002, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52414, 0, 0, 0, 0, 0, 10, 128921, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Cast \'Drag Mine Cart\''),
(-128901, 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 12890100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Start Path 12889200'),
(-128901, 0, 1003, 1004, 109, 0, 100, 0, 0, 12890100, 0, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 10, 128921, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12889200 Finished - Despawn In 2000 ms'),
(-128901, 0, 1004, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12889200 Finished - Despawn In 2000 ms'),
(-128901, 0, 1005, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 10, 128921, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Just Died - Despawn In 1000 ms'),
(-128901, 0, 1006, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52414, 0, 0, 0, 0, 0, 10, 128921, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Evade - Cast \'Drag Mine Cart\'');

-- Update Mine Car SAI.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28821;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28821) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28821, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 54173, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mine Car - On Respawn - Cast \'Drag Mine Cart Check\'');

-- Set Legacy spawn for Mine Cars
DELETE FROM `spawn_group_template` WHERE `groupId` = 104;
INSERT INTO `spawn_group_template` (`groupId`, `groupName`, `groupFlags`) VALUES
(104, 'Scarlet Mine - Miner & Mine Car pairs (compatibility respawn)', 2);

DELETE FROM `spawn_group` WHERE `groupId` = 104;
INSERT INTO `spawn_group` (`groupId`, `spawnType`, `spawnId`) VALUES
(104, 0, 128902),
(104, 0, 128903),
(104, 0, 128904),
(104, 0, 128905),
(104, 0, 128906),
(104, 0, 128907),
(104, 0, 128908),
(104, 0, 128909),
(104, 0, 128921);

-- Set Creature Formations (Scarlet Miner/Mine Car)
DELETE FROM `creature_formations` WHERE (`LeaderGUID` IN (128892, 128893, 128894, 128895, 128896, 128897, 128898, 128899, 128901));
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(128892, 128892, 0, 0, 512, 0, 0),
(128892, 128902, 3, 180, 512, 0, 0),
(128893, 128893, 0, 0, 512, 0, 0),
(128893, 128903, 3, 180, 512, 0, 0),
(128894, 128894, 0, 0, 512, 0, 0),
(128894, 128904, 3, 180, 512, 0, 0),
(128895, 128895, 0, 0, 512, 0, 0),
(128895, 128905, 3, 180, 512, 0, 0),
(128896, 128896, 0, 0, 512, 0, 0),
(128896, 128906, 3, 180, 512, 0, 0),
(128897, 128897, 0, 0, 512, 0, 0),
(128897, 128909, 3, 180, 512, 0, 0),
(128898, 128898, 0, 0, 512, 0, 0),
(128898, 128907, 3, 180, 512, 0, 0),
(128899, 128899, 0, 0, 512, 0, 0),
(128899, 128908, 3, 180, 512, 0, 0),
(128901, 128901, 0, 0, 512, 0, 0),
(128901, 128921, 3, 180, 512, 0, 0);
