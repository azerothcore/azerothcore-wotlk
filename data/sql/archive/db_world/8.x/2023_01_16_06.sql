-- DB update 2023_01_16_05 -> 2023_01_16_06
-- Delete useless spawn
DELETE FROM `creature` WHERE `id1` = 3695 AND `guid` = 37101;
DELETE FROM `creature_addon` WHERE `guid`=37101;

-- Rebuild Waypoints, use correct entry numbering
DELETE FROM `waypoints` WHERE `entry`=3695 AND `point_comment`='Grimclaw';
DELETE FROM `waypoints` WHERE `entry`=369500 AND `point_comment`='Grimclaw';
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(369500, 1 , 6409.01, 381.597, 13.7997, NULL, 0, 'Grimclaw'),
(369500, 2 , 6422.38, 398.542, 11.1623, NULL, 0, 'Grimclaw'),
(369500, 3 , 6429.16, 395.692, 11.6041, NULL, 0, 'Grimclaw'),
(369500, 4 , 6437.87, 372.912, 13.9415, NULL, 0, 'Grimclaw'),
(369500, 5 , 6436.29, 366.529, 13.9415, NULL, 0, 'Grimclaw'),
(369500, 6 , 6437.87, 372.912, 13.9415, NULL, 0, 'Grimclaw'),
(369500, 7 , 6429.16, 395.692, 11.6041, NULL, 0, 'Grimclaw'),
(369500, 8 , 6422.38, 398.542, 11.1623, NULL, 0, 'Grimclaw'),
(369500, 9 , 6409.01, 381.597, 13.7997, NULL, 0, 'Grimclaw'),
(369500, 10, 6398.35, 363.201, 17.3994, NULL, 0, 'Grimclaw'),
(369500, 11, 6352.56, 354.425, 22.3815, NULL, 0, 'Grimclaw'),
(369500, 12, 6319.38, 323.683, 25.1191, NULL, 0, 'Grimclaw'),
(369500, 13, 6301.5, 316.65, 23.0324, NULL, 0, 'Grimclaw'),
(369500, 14, 6191.09, 317.576, 27.3374, NULL, 0, 'Grimclaw'),
(369500, 15, 6147.81, 283.587, 24.2095, NULL, 0, 'Grimclaw'),
(369500, 16, 6123.43, 274.89, 19.8536, NULL, 0, 'Grimclaw'),
(369500, 17, 6065.77, 272.715, 21.2867, NULL, 0, 'Grimclaw'),
(369500, 18, 5974.22, 230.715, 20.3199, NULL, 0, 'Grimclaw'),
(369500, 19, 5939.16, 231.44, 23.4428, NULL, 0, 'Grimclaw'),
(369500, 20, 5815.32, 281.89, 24.3671, NULL, 0, 'Grimclaw'),
(369500, 21, 5771.04, 285.439, 20.6572, NULL, 0, 'Grimclaw'),
(369500, 22, 5735.43, 310.241, 20.5052, NULL, 0, 'Grimclaw'),
(369500, 23, 5669.04, 316.407, 18.5259, NULL, 0, 'Grimclaw'),
(369500, 24, 5582.47, 320.047, 26.3041, NULL, 0, 'Grimclaw'),
(369500, 25, 5527.95, 310.312, 27.8405, NULL, 0, 'Grimclaw'),
(369500, 26, 5460.87, 279.267, 30.6273, NULL, 0, 'Grimclaw'),
(369500, 27, 5418.4, 283.044, 31.069, NULL, 0, 'Grimclaw'),
(369500, 28, 5381.87, 285.215, 27.5948, NULL, 0, 'Grimclaw'),
(369500, 29, 5345.37, 279.313, 26.8274, NULL, 0, 'Grimclaw'),
(369500, 30, 5321.15, 263.386, 27.5151, NULL, 0, 'Grimclaw'),
(369500, 31, 5321.15, 263.386, 27.5151, NULL, 0, 'Grimclaw'),
(369500, 32, 5288.17, 250.073, 28.2502, NULL, 0, 'Grimclaw'),
(369500, 33, 5241.46, 246.278, 31.6904, NULL, 0, 'Grimclaw'),
(369500, 34, 5194.33, 249.196, 34.3226, NULL, 0, 'Grimclaw'),
(369500, 35, 5140.13, 247.678, 29.921, NULL, 0, 'Grimclaw'),
(369500, 36, 5073.81, 240.749, 27.4628, NULL, 0, 'Grimclaw'),
(369500, 37, 4985.4, 213.646, 38.6348, NULL, 0, 'Grimclaw'),
(369500, 38, 4963.03, 214.232, 40.756, NULL, 0, 'Grimclaw'),
(369500, 39, 4928.5, 218.963, 43.548, NULL, 0, 'Grimclaw'),
(369500, 40, 4865.44, 218.137, 49.9904, NULL, 0, 'Grimclaw'),
(369500, 41, 4794.28, 221.649, 48.6959, NULL, 0, 'Grimclaw');

-- Update SAI to conform to new waypoints and remove unused rows
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 3695) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3695, 0, 0, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 53, 1, 369500, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On Respawn - Start Waypoint'),
(3695, 0, 1, 0, 40, 0, 100, 0, 1, 369500, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 3693, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On WP 1 Reached (Path 369500) - Talk 0 (Terenthis)'),
(3695, 0, 2, 0, 40, 0, 100, 512, 5, 369500, 0, 0, 0, 80, 369500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On WP 5 Reached (Path 369500) - Run Actionlist'),
(3695, 0, 3, 0, 40, 0, 100, 512, 41, 369500, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grimclaw - On WP 41 Reached (Path 369500) - Despawn');
