-- DB update 2023_04_19_04 -> 2023_04_19_05
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19952) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19952, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodmaul Geomancer - On Just Died - Say Line 1'),
(19952, 0, 1, 0, 4, 0, 35, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodmaul Geomancer - On Aggro - Say Line 0'),
(19952, 0, 2, 0, 1, 0, 100, 0, 0, 0, 1800000, 1800000, 0, 11, 12544, 33, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodmaul Geomancer - Out of Combat - Keep up \'Frost Armor\''),
(19952, 0, 3, 0, 0, 0, 100, 0, 0, 0, 2400, 3800, 0, 11, 9053, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodmaul Geomancer - In Combat - Cast \'Fireball\'');
