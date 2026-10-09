--
SET @PATH := 73123 * 10;

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 73123 AND `id` = 20730;

DELETE FROM `creature_addon` WHERE `guid` = 73123;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(73123, @PATH, 0, 0, 1, 0, 0, NULL);

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 1, 2538.94, 6616.49, 4.05629, NULL, 0, 0, 0, 100, 0),
(@PATH, 2, 2525.1, 6608.91, 16.4708, NULL, 0, 0, 0, 100, 0),
(@PATH, 3, 2519.54, 6604.27, 23.8473, NULL, 0, 0, 0, 100, 0),
(@PATH, 4, 2506.05, 6600.16, 23.7941, NULL, 0, 0, 0, 100, 0),
(@PATH, 5, 2503.83, 6595.12, 24.0459, 4.68721, 20000, 0, 0, 100, 0),
(@PATH, 6, 2510.76, 6598.82, 24.5021, NULL, 0, 0, 0, 100, 0),
(@PATH, 7, 2519.74, 6604.36, 23.8362, NULL, 0, 0, 0, 100, 0),
(@PATH, 8, 2525.68, 6609.12, 15.8616, NULL, 0, 0, 0, 100, 0),
(@PATH, 9, 2539.41, 6616.76, 3.88227, NULL, 0, 0, 0, 100, 0),
(@PATH, 10, 2556.79, 6621.96, 9.41668, NULL, 0, 0, 0, 100, 0),
(@PATH, 11, 2563.62, 6623.65, 11.6515, NULL, 0, 0, 0, 100, 0),
(@PATH, 12, 2577.18, 6627.01, 13.582, NULL, 0, 0, 0, 100, 0),
(@PATH, 13, 2584.94, 6640.67, 17.6012, 3.78479, 30000, 0, 0, 100, 0),
(@PATH, 14, 2576.62, 6626.54, 13.3763, NULL, 0, 0, 0, 100, 0),
(@PATH, 15, 2563.39, 6623.55, 11.5663, NULL, 0, 0, 0, 100, 0),
(@PATH, 16, 2556.55, 6621.91, 9.32233, NULL, 0, 0, 0, 100, 0);
