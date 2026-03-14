-- DB update 2025_10_12_06 -> 2025_10_14_00

-- Move Waypoint from 'waypoints' to 'waypoint_data'
DELETE FROM `waypoints` WHERE `entry` = 27482;
DELETE FROM `waypoint_data` WHERE `id` = 2748200;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(2748200, 1, 4105.28, -2917.96, 280.32, NULL, 0, 1, 0, 100, 0),
(2748200, 2, 4048.68, -2936.74, 275.192, NULL, 0, 1, 0, 100, 0);

-- Edit SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27482;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 27482) AND (`source_type` = 0) AND (`id` IN (5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27482, 0, 5, 0, 109, 0, 100, 0, 0, 2748200, 0, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wounded Westfall Infantry - On Path 2748200 Finished - Despawn In 2000 ms');

-- Edit Action List
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2748200) AND (`source_type` = 9) AND (`id` IN (5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2748200, 9, 5, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 232, 2748200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wounded Westfall Infantry - Actionlist - Start Path 2748200');
