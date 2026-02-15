-- DB update 2024_10_02_00 -> 2024_10_02_01
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 3672) AND (`source_type` = 0) AND (`id` IN (3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3672, 0, 3, 0, 2, 0, 100, 1, 0, 50, 0, 0, 0, 0, 11, 8041, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boahn - Between 0-50% Health - Cast \'Snake Form\'');
