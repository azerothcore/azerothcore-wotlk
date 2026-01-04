-- DB update 2024_10_16_00 -> 2024_10_16_01

UPDATE `creature` SET `position_x` = 1415.4373, `position_y` = -5752.8945, `position_z` = 131.30084, `orientation` = 3.839396476745605468, `wander_distance` = 0, `MovementType` = 2, `CreateObject` = 1, `VerifiedBuild` = 56713 WHERE `id1` = 28594 AND `guid` = 129165;
UPDATE `creature` SET `position_x` = 1418.6387, `position_y` = -5758.492,  `position_z` = 131.24905, `orientation` = 1.177735805511474609, `wander_distance` = 0, `MovementType` = 2, `CreateObject` = 1, `VerifiedBuild` = 56713 WHERE `id1` = 28594 AND `guid` = 129168;
UPDATE `creature` SET `position_x` = 1360.4492, `position_y` = -5683.808,  `position_z` = 138.74478, `orientation` = 5.676506996154785156, `CreateObject` = 1, `VerifiedBuild` = 56713 WHERE `id1` = 28594 AND `guid` = 129169;
UPDATE `creature` SET `position_x` = 1406.4192, `position_y` = -5723.9375, `position_z` = 132.38057, `orientation` = 5.36331796646118164,  `wander_distance` = 0, `MovementType` = 0, `CreateObject` = 1, `VerifiedBuild` = 56713 WHERE `id1` = 28594 AND `guid` = 129170;
UPDATE `creature` SET `position_x` = 1412.2305, `position_y` = -5731.557,  `position_z` = 131.75316, `orientation` = 5.366878509521484375, `wander_distance` = 0, `MovementType` = 2, `CreateObject` = 1, `VerifiedBuild` = 56713 WHERE `id1` = 28594 AND `guid` = 129171;

DELETE FROM `waypoint_data` WHERE `id` = 12916500;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(12916500, 1,  1410.3698, -5762.8335, 131.43745, NULL, 0, 0, 0, 100, 0),
(12916500, 2,  1407.5739, -5774.8276, 131.33566, NULL, 0, 0, 0, 100, 0),
(12916500, 3,  1400.0348, -5789.2324, 131.22272, NULL, 0, 0, 0, 100, 0),
(12916500, 4,  1397.7992, -5801.5757, 131.2285,  NULL, 0, 0, 0, 100, 0),
(12916500, 5,  1402.9713, -5814.936,  131.2145,  NULL, 0, 0, 0, 100, 0),
(12916500, 6,  1419.8129, -5832.764,  131.1969,  NULL, 0, 0, 0, 100, 0),
(12916500, 7,  1433.2709, -5847.9785, 131.21193, NULL, 0, 0, 0, 100, 0),
(12916500, 8,  1441.0192, -5854.522,  131.21257, NULL, 0, 0, 0, 100, 0),
(12916500, 9,  1453.899,  -5856.497,  131.2154,  NULL, 0, 0, 0, 100, 0),
(12916500, 10, 1480.6685, -5854.989,  131.22208, NULL, 0, 0, 0, 100, 0),
(12916500, 11, 1492.9026, -5854.279,  131.21404, NULL, 0, 0, 0, 100, 0),
(12916500, 12, 1492.9155, -5843.5674, 131.21198, NULL, 0, 0, 0, 100, 0),
(12916500, 13, 1488.3405, -5813.3306, 131.21085, NULL, 0, 0, 0, 100, 0),
(12916500, 14, 1478.0803, -5793.954,  131.22769, NULL, 0, 0, 0, 100, 0),
(12916500, 15, 1465.781,  -5777.6206, 131.27104, NULL, 0, 0, 0, 100, 0),
(12916500, 16, 1445.4419, -5754.9077, 131.21011, NULL, 0, 0, 0, 100, 0),
(12916500, 17, 1424.6149, -5745.1987, 131.20967, NULL, 0, 0, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE `id` = 12916800;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(12916800, 1,  1423.784,  -5753.6196, 131.21034, NULL, 0, 0, 0, 100, 0),
(12916800, 2,  1438.4303, -5755.653,  131.21004, NULL, 0, 0, 0, 100, 0),
(12916800, 3,  1453.449,  -5772.697,  131.21564, NULL, 0, 0, 0, 100, 0),
(12916800, 4,  1472.0319, -5793.676,  131.21124, NULL, 0, 0, 0, 100, 0),
(12916800, 5,  1480.9645, -5806.4946, 131.21095, NULL, 0, 0, 0, 100, 0),
(12916800, 6,  1487.4835, -5827.0117, 131.21222, NULL, 0, 0, 0, 100, 0),
(12916800, 7,  1487.8892, -5848.086,  131.2139,  NULL, 0, 0, 0, 100, 0),
(12916800, 8,  1484.236,  -5850.959,  131.21649, NULL, 0, 0, 0, 100, 0),
(12916800, 9,  1461.8696, -5851.4355, 131.23096, NULL, 0, 0, 0, 100, 0),
(12916800, 10, 1441.8431, -5850.792,  131.2129,  NULL, 0, 0, 0, 100, 0),
(12916800, 11, 1423.0482, -5831.1094, 131.20496, NULL, 0, 0, 0, 100, 0),
(12916800, 12, 1406.6604, -5813.7505, 131.21092, NULL, 0, 0, 0, 100, 0),
(12916800, 13, 1400.523,  -5801.3213, 131.21956, NULL, 0, 0, 0, 100, 0),
(12916800, 14, 1404.7975, -5791.418,  131.21114, NULL, 0, 0, 0, 100, 0),
(12916800, 15, 1413.1937, -5771.624,  131.27168, NULL, 0, 0, 0, 100, 0),
(12916800, 16, 1418.6387, -5758.492,  131.24905, NULL, 0, 0, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE `id` = 12917100;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(12917100, 1, 1422.7795, -5747.4033, 131.20946, NULL, 0, 0, 0, 100, 0),
(12917100, 2, 1412.2305, -5731.557,  131.75316, NULL, 0, 0, 0, 100, 0),
(12917100, 3, 1394.4702, -5708.2007, 135.60547, NULL, 0, 0, 0, 100, 0),
(12917100, 4, 1385.6752, -5701.634,  138.07877, NULL, 0, 0, 0, 100, 0),
(12917100, 5, 1369.9221, -5690.5527, 138.07875, NULL, 0, 0, 0, 100, 0),
(12917100, 6, 1385.6752, -5701.634,  138.07877, NULL, 0, 0, 0, 100, 0),
(12917100, 7, 1394.4702, -5708.2007, 135.60547, NULL, 0, 0, 0, 100, 0);

DELETE FROM `creature_formations` WHERE `leaderGUID` = 129171 AND `memberGUID` = 129170;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(129171, 129171, 0, 0, 0, 0, 0),
(129171, 129170, 10, 180, 512, 0, 0);

DELETE FROM `creature_addon` WHERE `guid` IN (129165, 129168, 129171);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(129165, 12916500, 0, 0, 0, 0, 0, NULL),
(129168, 12916800, 0, 0, 0, 0, 0, NULL),
(129171, 12917100, 0, 0, 0, 0, 0, NULL);
