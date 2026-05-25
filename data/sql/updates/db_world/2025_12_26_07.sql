-- DB update 2025_12_26_06 -> 2025_12_26_07
--
UPDATE `event_scripts` SET `x`=2932.6313, `y`=-4488.1055, `z`=287.76904, `o`=3.298672199249267578 WHERE `id`=15726;
-- From Build 47720 sniff
UPDATE `creature_template` SET `unit_flags` = 32768 WHERE (`entry` = 24173);

DELETE FROM `waypoint_data` WHERE `id` = 241731;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `move_type`) VALUES
(241731, 1, 2916.6135, -4508.7236, 278.58325, 1),
(241731, 2, 2922.0066, -4525.9634, 275.11548, 1),
(241731, 3, 2924.3655, -4538.596, 273.8706, 1),
(241731, 4, 2931.4036, -4548.0923, 273.6897, 1),
(241731, 5, 2944.4275, -4555.303, 273.6897, 1);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24173;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24173);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24173, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostgore - On Respawn - Set Flags Immune To Players'),
(24173, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 241731, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostgore - On Respawn - Start Path 241731'),
(24173, 0, 2, 0, 108, 0, 100, 0, 5, 241731, 0, 0, 0, 0, 80, 2417300, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostgore - On Point 5 of Path 241731 Reached - Run Script'),
(24173, 0, 3, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostgore - On Evade - Despawn Instant');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2417300);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2417300, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 0, 'Frostgore - Actionlist - Set Orientation Closest Player'),
(2417300, 9, 1, 0, 0, 0, 100, 0, 800, 800, 0, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostgore - Actionlist - Play Emote 1'),
(2417300, 9, 2, 0, 0, 0, 100, 0, 3600, 3600, 0, 0, 0, 0, 5, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostgore - Actionlist - Play Emote 25'),
(2417300, 9, 3, 0, 0, 0, 100, 0, 800, 800, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostgore - Actionlist - Remove Flags Immune To Players'),
(2417300, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 0, 'Frostgore - Actionlist - Start Attacking');
