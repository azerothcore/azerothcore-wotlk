--
SET @NPC := 37068 * 10; -- Delmanis the Hated GUID * 10
DELETE FROM `waypoint_data` WHERE `id` = @NPC;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@NPC, 1, 7131.11, -788.217, 68.1099, NULL, 0, 0, 0, 100, 0),
(@NPC, 2, 7132.32, -799.054, 67.0953, NULL, 0, 0, 0, 100, 0),
(@NPC, 3, 7133.39, -809.255, 64.1739, NULL, 0, 0, 0, 100, 0),
(@NPC, 4, 7132.59, -825.363, 60.0889, NULL, 0, 0, 0, 100, 0),
(@NPC, 5, 7136.05, -835.608, 60.3634, NULL, 0, 0, 0, 100, 0),
(@NPC, 6, 7145.68, -835.719, 57.8297, NULL, 0, 0, 0, 100, 0),
(@NPC, 7, 7154.45, -830.982, 54.855, NULL, 0, 0, 0, 100, 0),
(@NPC, 8, 7169.19, -830.285, 49.7966, NULL, 0, 0, 0, 100, 0),
(@NPC, 9, 7177.84, -833.738, 47.2572, NULL, 0, 0, 0, 100, 0),
(@NPC, 10, 7188.62, -836.942, 44.124, NULL, 0, 0, 0, 100, 0),
(@NPC, 11, 7195.45, -832.049, 41.1274, NULL, 0, 0, 0, 100, 0),
(@NPC, 12, 7198.31, -820.495, 38.8156, NULL, 0, 0, 0, 100, 0),
(@NPC, 13, 7195.53, -810.478, 39.7979, NULL, 0, 0, 0, 100, 0),
(@NPC, 14, 7193.9, -797.967, 38.6929, NULL, 0, 0, 0, 100, 0),
(@NPC, 15, 7188.47, -794.707, 40.2705, NULL, 0, 0, 0, 100, 0),
(@NPC, 16, 7176.38, -793.998, 45.0664, NULL, 0, 0, 0, 100, 0),
(@NPC, 17, 7170.93, -787.923, 48.9857, NULL, 0, 0, 0, 100, 0),
(@NPC, 18, 7167.99, -774.225, 54.3081, NULL, 0, 0, 0, 100, 0),
(@NPC, 19, 7163.88, -768.924, 55.718, NULL, 0, 0, 0, 100, 0),
(@NPC, 20, 7161.04, -757.403, 53.9205, NULL, 0, 0, 0, 100, 0),
(@NPC, 21, 7154.14, -751.67, 52.9578, NULL, 0, 0, 0, 100, 0),
(@NPC, 22, 7145.89, -753.856, 52.5828, NULL, 0, 0, 0, 100, 0),
(@NPC, 23, 7147.18, -762.293, 52.9954, NULL, 0, 0, 0, 100, 0),
(@NPC, 24, 7166.4, -774.916, 54.5108, NULL, 0, 0, 0, 100, 0),
(@NPC, 25, 7170.04, -789.136, 49.0204, NULL, 0, 0, 0, 100, 0),
(@NPC, 26, 7179.69, -794.86, 43.3094, NULL, 0, 0, 0, 100, 0),
(@NPC, 27, 7192.23, -794.865, 38.9726, NULL, 0, 0, 0, 100, 0),
(@NPC, 28, 7197.34, -805.055, 38.384, NULL, 0, 0, 0, 100, 0),
(@NPC, 29, 7195.45, -829.248, 41.0215, NULL, 0, 0, 0, 100, 0),
(@NPC, 30, 7186.57, -837.96, 44.8655, NULL, 0, 0, 0, 100, 0),
(@NPC, 31, 7175.43, -845.945, 48.055, NULL, 0, 0, 0, 100, 0),
(@NPC, 32, 7166.09, -849.539, 50.4706, NULL, 0, 0, 0, 100, 0),
(@NPC, 33, 7158.55, -840.936, 53.0553, NULL, 0, 0, 0, 100, 0),
(@NPC, 34, 7152.62, -833.033, 55.3904, NULL, 0, 0, 0, 100, 0),
(@NPC, 35, 7137.15, -828.13, 58.7898, NULL, 0, 0, 0, 100, 0),
(@NPC, 36, 7138.54, -812.917, 62.9947, NULL, 0, 0, 0, 100, 0),
(@NPC, 37, 7139.28, -787.291, 67.7343, NULL, 1000, 0, 0, 100, 0),
(@NPC, 38, 7131.93, -780.942, 67.0546, NULL, 0, 0, 0, 100, 0);

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 37068;

DELETE FROM `creature_addon` WHERE `guid` = 37068;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(37068, @NPC, 0, 0, 1, 0, 0, '');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 3662 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 336200 AND `source_type` = 9; -- remove now unused wp scripts
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3662, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2400, 3800, 0, 0, 11, 20792, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Delmanis the Hated - In Combat CMC - Cast \'Frostbolt\''),
(3662, 0, 1, 0, 0, 0, 100, 0, 6000, 10000, 12000, 16000, 0, 0, 11, 7101, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Delmanis the Hated - In Combat - Cast \'Flame Blast\''),
(3662, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Delmanis the Hated - Between 0-15% Health - Flee For Assist (No Repeat)');

DELETE FROM `waypoints` WHERE `entry` = 3662;
