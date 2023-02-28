-- DB update 2022_12_22_07 -> 2022_12_22_08
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19283);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19283, 0, 0, 0, 1, 0, 100, 0, 5000, 30000, 45000, 45000, 0, 10, 12, 13, 64, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vagrant - Out of Combat - Play Random Emote (12, 13, 64)'),
(19283, 0, 1, 0, 1, 0, 100, 0, 30000, 60000, 45000, 90000, 0, 5, 26, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vagrant - Out of Combat - Play Emote 26'),
(19283, 0, 2, 0, 1, 0, 100, 0, 15000, 40000, 20000, 40000, 0, 10, 18, 20, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vagrant - Out of Combat - Play Random Emote (18, 20, 1)'),
(19283, 0, 3, 0, 1, 0, 100, 0, 30000, 300000, 240000, 520000, 0, 1, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 0, 'Vagrant - Out of Combat - Say Line 0');
