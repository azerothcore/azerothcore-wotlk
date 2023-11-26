-- DB update 2023_11_20_04 -> 2023_11_20_05
--
DELETE FROM `smart_scripts` WHERE `entryorguid` = 21218 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21218, 0, 0, 0, 0, 0, 100, 0, 16300, 19300, 10090, 19400, 0, 0, 11, 38572, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Vashj\'ir Honor Guard - In Combat - Cast Mortal Cleave'),
(21218, 0, 1, 0, 105, 0, 100, 0, 15750, 16850, 15750, 16850, 0, 5, 11, 38576, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Vashj\'ir Honor Guard - Victim Casting - Cast Knockback'),
(21218, 0, 2, 0, 0, 0, 100, 0, 7000, 12000, 13000, 17000, 0, 0, 11, 38945, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vashj\'ir Honor Guard - In Combat - Cast Frightening Shout'),
(21218, 0, 3, 4, 2, 0, 100, 1, 0, 50, 0, 0, 0, 0, 11, 38947, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vashj\'ir Honor Guard - Between Health 0-50% - Cast Frenzy'),
(21218, 0, 4, 0, 61, 0, 50, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vashj\'ir Honor Guard - Between Health 0-50% - Talk'),
(21218, 0, 5, 0, 12, 0, 100, 0, 0, 20, 15000, 15000, 0, 0, 11, 38959, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Vashj\'ir Honor Guard - Target Health 0-20% - Cast Execute');
