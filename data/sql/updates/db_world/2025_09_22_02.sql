-- DB update 2025_09_22_01 -> 2025_09_22_02
--
DELETE FROM `waypoints` WHERE `entry`=317020;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(317020, 1, 7326.43, 1289.52, 611.652, NULL, 0, 'Frostbrood Spawn');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 31702) AND (`source_type` = 0) AND (`id` IN (6));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31702, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 1, 317020, 0, 0, 0, 1, 8, 0, 0, 0, 0, 7326.43, 1289.52, 611.652, 0, 'Frostbrood Spawn - On Reached Point 1 - Start Waypoint Path 317020');
