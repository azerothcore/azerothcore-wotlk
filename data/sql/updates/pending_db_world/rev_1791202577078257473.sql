--
DELETE FROM `smart_scripts` WHERE `entryorguid` = 21300 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21300, 0, 0, 0, 1, 0, 100, 0, 5000, 10000, 20000, 30000, 0, 0, 11, 36274, 0, 0, 0, 0, 0, 10, 0, 21124, 0, 0, 0, 0, 0, 0, 'Fel Corrupter - Out of Combat - Cast \'36274\''),
(21300, 0, 1, 0, 0, 0, 100, 0, 2100, 3400, 5600, 6200, 0, 0, 11, 9613, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Fel Corrupter - In Combat - Cast \'9613\''),
(21300, 0, 2, 0, 0, 0, 100, 0, 2700, 4200, 24000, 32000, 0, 0, 11, 32063, 32, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Fel Corrupter - In Combat - Cast \'Corruption\'');
