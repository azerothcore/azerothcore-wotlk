-- DB update 2025_10_16_00 -> 2025_10_16_01

-- Set param 3 and 4 to 0.
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2889700) AND (`source_type` = 9) AND (`id` IN (1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2889700, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 113, 2889700, 2889706, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Ghoul - Actionlist - Start closest Waypoint 2889700 - 2889706');
