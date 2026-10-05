--
SET @PATH := 70141 * 10;

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 70141 AND `id` = 19657;

DELETE FROM `creature_addon` WHERE `guid` = 70141;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(70141, @PATH, 0, 0, 1, 0, 0, NULL);

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 1, 2952.34, 2280.58, 161.708, NULL, 0, 0, 0, 100, 0),
(@PATH, 2, 2963.22, 2285.29, 161.715, NULL, 0, 0, 0, 100, 0),
(@PATH, 3, 2972.13, 2290.53, 161.709, NULL, 0, 0, 0, 100, 0),
(@PATH, 4, 2981.27, 2296.16, 161.709, NULL, 0, 0, 0, 100, 0),
(@PATH, 5, 2985.89, 2298.46, 161.709, NULL, 0, 0, 0, 100, 0),
(@PATH, 6, 2991.7, 2294.17, 161.709, NULL, 0, 0, 0, 100, 0),
(@PATH, 7, 2998.74, 2293.21, 161.706, NULL, 0, 0, 0, 100, 0),
(@PATH, 8, 3005.23, 2292.41, 161.537, NULL, 0, 0, 0, 100, 0),
(@PATH, 9, 3011.54, 2291.28, 160.931, NULL, 0, 0, 0, 100, 0),
(@PATH, 10, 3012.24, 2298.92, 161.379, NULL, 0, 0, 0, 100, 0),
(@PATH, 11, 3011.92, 2302.38, 161.554, NULL, 0, 0, 0, 100, 0),
(@PATH, 12, 3012.24, 2298.92, 161.379, NULL, 0, 0, 0, 100, 0),
(@PATH, 13, 3011.54, 2291.28, 160.931, NULL, 0, 0, 0, 100, 0),
(@PATH, 14, 3005.23, 2292.41, 161.537, NULL, 0, 0, 0, 100, 0),
(@PATH, 15, 2998.74, 2293.21, 161.706, NULL, 0, 0, 0, 100, 0),
(@PATH, 16, 2991.7, 2294.17, 161.709, NULL, 0, 0, 0, 100, 0),
(@PATH, 17, 2985.89, 2298.46, 161.709, NULL, 0, 0, 0, 100, 0),
(@PATH, 18, 2981.27, 2296.16, 161.709, NULL, 0, 0, 0, 100, 0),
(@PATH, 19, 2972.13, 2290.53, 161.709, NULL, 0, 0, 0, 100, 0),
(@PATH, 20, 2963.22, 2285.29, 161.715, NULL, 0, 0, 0, 100, 0);

DELETE FROM `creature_formations` WHERE `memberGUID` IN (70141, 70089);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(70141, 70141, 0, 0, 3, 0, 0),
(70141, 70089, 3, 180, 515, 0, 0);
