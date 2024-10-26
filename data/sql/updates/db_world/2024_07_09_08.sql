-- DB update 2024_07_09_07 -> 2024_07_09_08
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 21268) AND (`source_type` = 0) AND (`id` IN (3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21268, 0, 3, 0, 106, 0, 100, 0, 6000, 9000, 12000, 18000, 0, 10, 11, 36994, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Netherstrand Longbow - On Hostile in Range - Cast \'Blink\'');
