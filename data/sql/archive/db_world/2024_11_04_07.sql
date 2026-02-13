-- DB update 2024_11_04_06 -> 2024_11_04_07
DELETE FROM `smart_scripts` WHERE `entryorguid` = 25002 AND `id` = 1;

INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `comment`) VALUES
(25002, 0, 1, 0, 0, 0, 100, 0, 5000, 10000, 0, 0, 11, 31598, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 'Unleashed Hellion - In Combat - Cast Rain of Fire');
