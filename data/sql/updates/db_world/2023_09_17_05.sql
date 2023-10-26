-- DB update 2023_09_17_04 -> 2023_09_17_05
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 21205);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21205, 0, 0, 0, 0, 0, 100, 0, 0, 5000, 20000, 35000, 0, 0, 11, 38363, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ravenous Flayer Matriarch - In Combat - Cast \'Gushing Wound\''),
(21205, 0, 1, 0, 0, 0, 100, 0, 0, 3000, 15000, 30000, 0, 0, 11, 36464, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ravenous Flayer Matriarch - In Combat - Cast \'The Den Mother`s Mark\''),
(21205, 0, 2, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 0, 2120500, 1, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ravenous Flayer Matriarch - On Respawn - Start Patrol Path 2120500'),
(21205, 0, 3, 0, 1, 0, 100, 0, 60000, 180000, 60000, 180000, 0, 0, 80, 2120500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ravenous Flayer Matriarch - Out of Combat - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2120500);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2120500, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 54, 30000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ravenous Flayer Matriarch - Actionlist - Pause Waypoint'),
(2120500, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 36691, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ravenous Flayer Matriarch - Actionlist - Cast \'Serverside - Lay Ravenous Flayer Egg\''),
(2120500, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 89, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ravenous Flayer Matriarch - Actionlist - Start Random Movement'),
(2120500, 9, 3, 0, 0, 0, 100, 0, 20000, 30000, 0, 0, 0, 0, 65, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ravenous Flayer Matriarch - Actionlist - Resume Waypoint');

DELETE FROM `creature` WHERE `id1` = 21205 AND `guid` = 85392;
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(85392, 21205, 530, 3520, 3520, -2730.536376953125, 1150.532958984375, 63.02117919921875, 3.796946525573730468, 300, 48069, 2, 'Scripted Pathing');

DELETE FROM `creature_addon` WHERE `guid` = 85392;
DELETE FROM `waypoint_data` WHERE `id` = 853920;

DELETE FROM `waypoints` WHERE `entry` = 2120500;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES
(2120500, 1 , -2746.24, 1138.448, 54.15343, 'Ravenous Flayer Matriarch'),
(2120500, 2 , -2762.292, 1128.408, 46.53087, 'Ravenous Flayer Matriarch'),
(2120500, 3 , -2729.597, 1104.097, 49.9248, 'Ravenous Flayer Matriarch'),
(2120500, 4 , -2727.395, 1087.502, 48.17071, 'Ravenous Flayer Matriarch'),
(2120500, 5 , -2728.122, 1075.56, 45.84283, 'Ravenous Flayer Matriarch'),
(2120500, 6 , -2710.212, 1072.808, 47.86968, 'Ravenous Flayer Matriarch'), 
(2120500, 7 , -2692.166, 1095.084, 51.25895, 'Ravenous Flayer Matriarch'), 
(2120500, 8 , -2676.87, 1087.67, 48.08696, 'Ravenous Flayer Matriarch'),
(2120500, 9 , -2651.984, 1074.549, 49.94732, 'Ravenous Flayer Matriarch'),
(2120500, 10, -2634.343, 1060.091, 50.21058, 'Ravenous Flayer Matriarch'),
(2120500, 11, -2619.968, 1053.699, 37.64632, 'Ravenous Flayer Matriarch'),
(2120500, 12, -2598.035, 1047.925, 43.43085, 'Ravenous Flayer Matriarch'),
(2120500, 13, -2571.256, 1035.177, 43.26862, 'Ravenous Flayer Matriarch'),
(2120500, 14, -2563.9033, 1032.3075, 37.875877, 'Ravenous Flayer Matriarch - Decomposed'),
(2120500, 15, -2561.1533, 1031.0575, 33.125877, 'Ravenous Flayer Matriarch - Decomposed'),
(2120500, 16, -2552.076, 1026.859, 37.60755, 'Ravenous Flayer Matriarch'),
(2120500, 17, -2521.413, 1022.475, 42.70882, 'Ravenous Flayer Matriarch'),
(2120500, 18, -2516.2585, 1031.3173, 39.342514, 'Ravenous Flayer Matriarch - Decomposed'),
(2120500, 19, -2508.908, 1042.702, 49.50398, 'Ravenous Flayer Matriarch'),
(2120500, 20, -2502.511, 1057.798, 53.36262, 'Ravenous Flayer Matriarch'),
(2120500, 21, -2518.216, 1084.736, 63.13983, 'Ravenous Flayer Matriarch'),
(2120500, 22, -2519.813, 1103.396, 66.57159, 'Ravenous Flayer Matriarch'),
(2120500, 23, -2526.526, 1123.956, 72.65863, 'Ravenous Flayer Matriarch'),
(2120500, 24, -2555.379, 1145.952, 76.91769, 'Ravenous Flayer Matriarch'),
(2120500, 25, -2574.61, 1140.253, 74.28946, 'Ravenous Flayer Matriarch'),
(2120500, 26, -2581.985, 1117.115, 68.20245, 'Ravenous Flayer Matriarch'),
(2120500, 27, -2606.013, 1116.443, 66.19119, 'Ravenous Flayer Matriarch'),
(2120500, 28, -2631.04, 1119.793, 64.49197, 'Ravenous Flayer Matriarch'),
(2120500, 29, -2661.714, 1119.632, 64.44809, 'Ravenous Flayer Matriarch'),
(2120500, 30, -2698.282, 1122.563, 58.28287, 'Ravenous Flayer Matriarch'),
(2120500, 31, -2731.417, 1141.435, 59.53944, 'Ravenous Flayer Matriarch');
