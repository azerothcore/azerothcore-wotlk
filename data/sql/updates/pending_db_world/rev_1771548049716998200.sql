UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7784;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 7784) AND (`source_type` = 0) AND (`id` IN (7));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7784, 0, 7, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 28, 68499, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Respawn - Remove Aura \'OOX Lift Off\'');

-- Add intermediate waypoints for hill between spawn and old WP1 to prevent terrain clipping
DELETE FROM `waypoints` WHERE `entry` = 7784;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `point_comment`) VALUES
(7784, 1, -8842.20, -4374.79, 43.75, NULL, 'Homing Robot OOX-17/TN'),
(7784, 2, -8833.24, -4373.24, 46.07, NULL, 'Homing Robot OOX-17/TN'),
(7784, 3, -8816.69, -4373.01, 35.18, NULL, 'Homing Robot OOX-17/TN'),
(7784, 4, -8803.74, -4370.74, 30.07, NULL, 'Homing Robot OOX-17/TN'),
(7784, 5, -8780.44, -4364.47, 23.23, NULL, 'Homing Robot OOX-17/TN'),
(7784, 6, -8752.49, -4366.43, 24.1011, NULL, 'Homing Robot OOX-17/TN'),
(7784, 7, -8724.97, -4352.23, 20.7446, NULL, 'Homing Robot OOX-17/TN'),
(7784, 8, -8708.82, -4353.28, 18.3696, NULL, 'Homing Robot OOX-17/TN'),
(7784, 9, -8685, -4379.19, 13.5678, NULL, 'Homing Robot OOX-17/TN'),
(7784, 10, -8656.83, -4388.01, 12.2752, NULL, 'Homing Robot OOX-17/TN'),
(7784, 11, -8612.75, -4397.25, 9.71276, NULL, 'Homing Robot OOX-17/TN'),
(7784, 12, -8578.57, -4408.65, 11.489, NULL, 'Homing Robot OOX-17/TN'),
(7784, 13, -8539.1, -4421.45, 12.6169, NULL, 'Homing Robot OOX-17/TN'),
(7784, 14, -8514.03, -4425.82, 13.8242, NULL, 'Homing Robot OOX-17/TN'),
(7784, 15, -8486.31, -4428.78, 11.637, NULL, 'Homing Robot OOX-17/TN'),
(7784, 16, -8446.95, -4440.72, 9.38521, NULL, 'Homing Robot OOX-17/TN'),
(7784, 17, -8417.6, -4445.19, 10.3852, NULL, 'Homing Robot OOX-17/TN'),
(7784, 18, -8388.9, -4448, 10.9963, NULL, 'Homing Robot OOX-17/TN'),
(7784, 19, -8352, -4447.59, 10.1347, NULL, 'Homing Robot OOX-17/TN'),
(7784, 20, -8327.56, -4442.51, 18.5852, NULL, 'Homing Robot OOX-17/TN'),
(7784, 21, -8262.68, -4426.01, 34.8352, NULL, 'Homing Robot OOX-17/TN'),
(7784, 22, -8161.73, -4410.54, 58.0852, NULL, 'Homing Robot OOX-17/TN');

-- Update SmartAI waypoint references (old WP16 is now WP19, old WP19 is now WP22)
UPDATE `smart_scripts` SET `event_param1` = 19 WHERE `entryorguid` = 7784 AND `source_type` = 0 AND `id` = 3;
UPDATE `smart_scripts` SET `event_param1` = 22 WHERE `entryorguid` = 7784 AND `source_type` = 0 AND `id` = 5;
