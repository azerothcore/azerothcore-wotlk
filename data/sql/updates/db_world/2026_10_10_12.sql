-- DB update 2026_10_10_11 -> 2026_10_10_12
--
SET @PATH := 83112 * 10;

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 83112 AND `id` = 22024;

DELETE FROM `creature_addon` WHERE `guid` = 83112;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(83112, @PATH, 0, 0, 1, 0, 0, NULL);

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 1, -3478.58, 2278.88, 64.3024, NULL, 0, 0, 0, 100, 0),
(@PATH, 2, -3465.33, 2287.22, 63.4117, NULL, 0, 0, 0, 100, 0),
(@PATH, 3, -3396.56, 2289.24, 62.6846, NULL, 0, 0, 0, 100, 0),
(@PATH, 4, -3375.29, 2283.54, 62.2904, NULL, 0, 0, 0, 100, 0),
(@PATH, 5, -3361.75, 2279.95, 61.9273, NULL, 0, 0, 0, 100, 0),
(@PATH, 6, -3346.63, 2278.56, 61.3279, NULL, 0, 0, 0, 100, 0),
(@PATH, 7, -3292.68, 2278.75, 60.6095, NULL, 0, 0, 0, 100, 0),
(@PATH, 8, -3365.18, 2279.23, 62.0737, NULL, 0, 0, 0, 100, 0),
(@PATH, 9, -3387.64, 2287.59, 62.3845, NULL, 0, 0, 0, 100, 0),
(@PATH, 10, -3399.74, 2289.47, 62.7643, NULL, 0, 0, 0, 100, 0),
(@PATH, 11, -3457.02, 2289.38, 63.4614, NULL, 0, 0, 0, 100, 0),
(@PATH, 12, -3465.55, 2286.99, 63.416, NULL, 0, 0, 0, 100, 0),
(@PATH, 13, -3476.52, 2280.52, 64.1385, NULL, 0, 0, 0, 100, 0),
(@PATH, 14, -3494.46, 2277.87, 65.362, NULL, 0, 0, 0, 100, 0);
