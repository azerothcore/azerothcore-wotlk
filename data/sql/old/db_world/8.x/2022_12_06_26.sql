-- DB update 2022_12_06_25 -> 2022_12_06_26
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 21033) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21033, 0, 0, 0, 0, 0, 100, 0, 0, 3000, 8000, 15000, 0, 11, 37839, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bladewing Bloodletter - In Combat - Cast \'Poison Spit\''),
(21033, 0, 1, 0, 0, 0, 100, 0, 3000, 5000, 13000, 18000, 0, 11, 37838, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bladewing Bloodletter - In Combat - Cast \'Blood Leech\'');
