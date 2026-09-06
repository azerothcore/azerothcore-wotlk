-- DB update 2025_11_29_03 -> 2025_11_30_00
--
DELETE FROM `smart_scripts` WHERE `entryorguid` = 1889 AND `source_type` = 0 AND `id` IN (0, 1, 2, 3);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1889, 0, 0, 0, 1, 0, 100, 0, 1000, 1000, 1000, 1000, 0, 0, 11, 12544, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Wizard - Out of Combat - Cast \'Frost Armor\''),
(1889, 0, 1, 0, 0, 0, 100, 0, 0, 0, 3400, 5400, 0, 0, 11, 20792, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Wizard - In Combat - Cast \'Frostbolt\''),
(1889, 0, 2, 0, 106, 0, 100, 0, 12500, 45000, 15000, 45000, 0, 10, 11, 11831, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Wizard - On Hostile in Range - Cast \'Frost Nova\''),
(1889, 0, 3, 0, 0, 0, 100, 1, 3000, 5000, 14000, 20000, 0, 0, 11, 4980, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Wizard - In Combat - Cast \'Quick Frost Ward\' (No Repeat)');
