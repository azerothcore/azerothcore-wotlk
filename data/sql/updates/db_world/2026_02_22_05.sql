-- DB update 2026_02_22_04 -> 2026_02_22_05
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7784;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 7784) AND (`source_type` = 0) AND (`id` IN (7));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7784, 0, 7, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 28, 68499, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Respawn - Remove Aura \'OOX Lift Off\'');

-- Update waypoints with sniffed data
DELETE FROM `waypoints` WHERE `entry` = 7784;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `point_comment`) VALUES
(7784, 1, -8832.505, -4374.4556, 45.228176, NULL, 'Homing Robot OOX-17/TN'),
(7784, 2, -8810.634, -4373.8345, 32.52725, NULL, 'Homing Robot OOX-17/TN'),
(7784, 3, -8794.969, -4366.311, 25.909113, NULL, 'Homing Robot OOX-17/TN'),
(7784, 4, -8752.488, -4366.4326, 24.156054, NULL, 'Homing Robot OOX-17/TN'),
(7784, 5, -8724.97, -4352.2266, 20.758305, NULL, 'Homing Robot OOX-17/TN'),
(7784, 6, -8708.822, -4353.277, 18.39893, NULL, 'Homing Robot OOX-17/TN'),
(7784, 7, -8684.997, -4379.1943, 13.580014, NULL, 'Homing Robot OOX-17/TN'),
(7784, 8, -8656.829, -4388.013, 12.268159, NULL, 'Homing Robot OOX-17/TN'),
(7784, 9, -8612.755, -4397.2524, 9.681026, NULL, 'Homing Robot OOX-17/TN'),
(7784, 10, -8578.566, -4408.652, 11.647685, NULL, 'Homing Robot OOX-17/TN'),
(7784, 11, -8539.096, -4421.452, 12.621063, NULL, 'Homing Robot OOX-17/TN'),
(7784, 12, -8514.029, -4425.8203, 13.824177, NULL, 'Homing Robot OOX-17/TN'),
(7784, 13, -8486.308, -4428.784, 11.725893, NULL, 'Homing Robot OOX-17/TN'),
(7784, 14, -8446.95, -4440.7183, 9.385215, NULL, 'Homing Robot OOX-17/TN'),
(7784, 15, -8417.598, -4445.191, 10.350303, NULL, 'Homing Robot OOX-17/TN'),
(7784, 16, -8388.8955, -4448.0015, 10.9764805, NULL, 'Homing Robot OOX-17/TN'),
(7784, 17, -8352.005, -4447.594, 10.134734, NULL, 'Homing Robot OOX-17/TN'),
(7784, 18, -8352.005, -4447.594, 10.134734, 0.0104949, 'Homing Robot OOX-17/TN'),
-- Fly waypoints to give lift off time to play
(7784, 19, -8327.56, -4442.5103, 18.585197, NULL, 'Homing Robot OOX-17/TN'),
(7784, 20, -8262.676, -4426.0054, 34.8352, NULL, 'Homing Robot OOX-17/TN'),
(7784, 21, -8161.7275, -4410.5435, 58.08519, NULL, 'Homing Robot OOX-17/TN');

-- Update SmartAI waypoint references to match sniffed data
-- ID 3: Ambush/pause trigger on WP18 (pause point with orientation)
-- ID 5: Despawn on WP21 (final fly waypoint)
UPDATE `smart_scripts` SET `event_param1` = 18 WHERE `entryorguid` = 7784 AND `source_type` = 0 AND `id` = 3;
UPDATE `smart_scripts` SET `event_param1` = 21 WHERE `entryorguid` = 7784 AND `source_type` = 0 AND `id` = 5;
