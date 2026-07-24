-- DB update 2025_10_11_01 -> 2025_10_11_02
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29920);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29920, 0, 0, 0, 0, 0, 100, 0, 10000, 15000, 10000, 15000, 0, 0, 11, 55652, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Ruins Dweller - In Combat - Cast \'Spring\''),
(29920, 0, 1, 0, 0, 0, 100, 0, 2000, 7000, 8000, 14000, 0, 0, 11, 55643, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ruins Dweller - In Combat - Cast \'Regurgitate\''),
(29920, 0, 2, 0, 31, 0, 100, 0, 55652, 0, 0, 0, 0, 0, 14, 0, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ruins Dweller - On Target Spellhit \'Spring\' - Set All Threat 0-100');
