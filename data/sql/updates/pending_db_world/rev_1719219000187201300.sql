-- Worg Master Kruush, Ripp, Feng
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (19442,19458,19459));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19442, 0, 0, 0, 0, 0, 100, 0, 5000, 5000, 8000, 8000, 0, 0, 11, 30478, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Worg Master Kruush - In Combat - Cast \'Hemorrhage\''),
(19442, 0, 1, 2, 2, 0, 100, 1, 0, 25, 0, 0, 0, 0, 11, 8599, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Worg Master Kruush - Between 0-25% Health - Cast \'Enrage\' (No Repeat)'),
(19442, 0, 2, 0, 61, 0, 100, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Worg Master Kruush - Between 0-25% Health - Say Line 1 (No Repeat)'),
(19442, 0, 3, 4, 4, 0, 100, 1, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Worg Master Kruush - On Aggro - Store Targetlist (No Repeat)'),
(19442, 0, 4, 5, 61, 0, 100, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Worg Master Kruush - On Aggro - Say Line 0 (No Repeat)'),
(19442, 0, 5, 6, 61, 0, 100, 1, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 9, 19458, 0, 30, 1, 0, 0, 0, 0, 'Worg Master Kruush - On Aggro - Send Target 1 (No Repeat)'),
(19442, 0, 6, 7, 61, 0, 100, 1, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 9, 19459, 0, 30, 1, 0, 0, 0, 0, 'Worg Master Kruush - On Aggro - Send Target 1 (No Repeat)'),
(19442, 0, 7, 8, 61, 0, 100, 1, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 9, 19458, 0, 30, 1, 0, 0, 0, 0, 'Worg Master Kruush - On Aggro - Set Data 1 1 (No Repeat)'),
(19442, 0, 8, 0, 61, 0, 100, 1, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 9, 19459, 0, 30, 1, 0, 0, 0, 0, 'Worg Master Kruush - On Aggro - Set Data 1 1 (No Repeat)'),
(19442, 0, 9, 10, 6, 0, 100, 1, 0, 0, 0, 0, 0, 0, 45, 2, 1, 0, 0, 0, 0, 9, 19458, 0, 30, 1, 0, 0, 0, 0, 'Worg Master Kruush - On Just Died - Set Data 2 1 (No Repeat)'),
(19442, 0, 10, 0, 61, 0, 100, 1, 0, 0, 0, 0, 0, 0, 45, 2, 1, 0, 0, 0, 0, 9, 19459, 0, 30, 1, 0, 0, 0, 0, 'Worg Master Kruush - On Just Died - Set Data 2 1 (No Repeat)'),
(19458, 0, 0, 0, 38, 0, 100, 0, 2, 1, 0, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ripp - On Data Set 2 1 - Flee For Assist'),
(19458, 0, 1, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Ripp - On Data Set 1 1 - Start Attacking'),
(19459, 0, 0, 0, 38, 0, 100, 0, 2, 1, 0, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Feng - On Data Set 2 1 - Flee For Assist'),
(19459, 0, 1, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Feng - On Data Set 1 1 - Start Attacking');
