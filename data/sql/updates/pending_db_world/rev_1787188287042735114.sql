--
-- Timmy the Cruel
DELETE FROM `smart_scripts` WHERE `entryorguid` = 10808 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10808, 0, 0, 0, 0, 0, 100, 0, 3000, 8000, 9000, 14000, 0, 0, 11, 17470, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Timmy the Cruel - In Combat - Cast Ravenous Claw'),
(10808, 0, 1, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Timmy the Cruel - Between 0-30% Health - Cast Enrage'),
(10808, 0, 3, 4, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Timmy the Cruel - On Respawn - Set Invisible'),
(10808, 0, 4, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Timmy the Cruel - On Respawn - Set Friendly Faction'),
(10808, 0, 5, 0, 60, 0, 100, 769, 5000, 5000, 5000, 5000, 0, 0, 80, 1080800, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Timmy the Cruel - On Update - Run Emergence Script');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 1080800 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1080800, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Timmy the Cruel - On Script - Set Visible'),
(1080800, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 50142, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Timmy the Cruel - On Script - Cast Emerge'),
(1080800, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Timmy the Cruel - On Script - Say Line 0'),
(1080800, 9, 3, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 2, 21, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Timmy the Cruel - On Script - Set Hostile Faction');
