-- DB update 2026_10_13_01 -> 2026_10_13_02
--
SET @PATH := 74397 * 10;

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 74397 AND `id` = 21209;

DELETE FROM `creature_addon` WHERE `guid` = 74397;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(74397, @PATH, 0, 0, 1, 0, 0, NULL);

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 1, -599.56, 2903.23, 59.2082, NULL, 0, 0, 0, 100, 0),
(@PATH, 2, -604.013, 2905.87, 59.2091, NULL, 4000, 0, 0, 100, 0),
(@PATH, 3, -592.663, 2899.05, 59.2054, NULL, 0, 0, 0, 100, 0),
(@PATH, 4, -590.73, 2894.65, 59.1648, NULL, 0, 0, 0, 100, 0),
(@PATH, 5, -592.049, 2889.87, 58.6217, NULL, 0, 0, 0, 100, 0),
(@PATH, 6, -595.858, 2889, 59.0983, NULL, 0, 0, 0, 100, 0),
(@PATH, 7, -595.788, 2890.9, 59.204, 1.29154, 20000, 0, 0, 100, 0),
(@PATH, 8, -590.014, 2890.57, 58.4939, NULL, 0, 0, 0, 100, 0),
(@PATH, 9, -586.498, 2891.9, 59.0853, NULL, 0, 0, 0, 100, 0),
(@PATH, 10, -583.659, 2893.53, 59.1767, NULL, 0, 0, 0, 100, 0),
(@PATH, 11, -584.432, 2895.45, 59.162, NULL, 20000, 0, 0, 100, 0),
(@PATH, 12, -589.103, 2891.03, 58.5946, NULL, 0, 0, 0, 100, 0),
(@PATH, 13, -591.657, 2895.6, 59.2043, NULL, 0, 0, 0, 100, 0);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21209;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 21209 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (2120900, 2120901) AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21209, 0, 0, 0, 108, 0, 100, 0, 2, @PATH, 0, 0, 0, 0, 80, 2120900, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dumphry - On Point 2 of Path 743970 Reached - Run Script'),
(21209, 0, 1, 0, 108, 0, 100, 0, 7, @PATH, 0, 0, 0, 0, 80, 2120901, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dumphry - On Point 7 of Path 743970 Reached - Run Script'),
(21209, 0, 2, 0, 108, 0, 100, 0, 11, @PATH, 0, 0, 0, 0, 80, 2120901, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dumphry - On Point 11 of Path 743970 Reached - Run Script'),
(2120900, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dumphry - Actionlist - Set Flag Standstate Kneel'),
(2120900, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dumphry - Actionlist - Remove Flag Standstate Kneel'),
(2120901, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 133, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dumphry - Actionlist - Set Emote State Use Standing No Sheathe'),
(2120901, 9, 1, 0, 0, 0, 100, 0, 20000, 20000, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dumphry - Actionlist - Set Emote State None');
