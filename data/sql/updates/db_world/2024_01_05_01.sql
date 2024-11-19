-- DB update 2024_01_05_00 -> 2024_01_05_01
--
DELETE FROM `smart_scripts` WHERE `entryorguid` = 16977 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16977, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2400, 3800, 0, 0, 11, 20823, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Arch Mage Xintor - In Combat - Cast \'Fireball\''),
(16977, 0, 1, 0, 0, 0, 100, 0, 6000, 8000, 9000, 12000, 0, 0, 11, 15735, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Arch Mage Xintor - In Combat - Cast \'Arcane Missiles\''),
(16977, 0, 2, 0, 2, 0, 100, 1, 0, 50, 0, 0, 0, 0, 11, 33245, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Arch Mage Xintor - Between 0-50% Health - Cast \'Ice Barrier\' (No Repeat)'),
(16977, 0, 3, 0, 2, 0, 100, 1, 0, 50, 0, 0, 0, 0, 11, 29458, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Arch Mage Xintor - Between 0-50% Health - Cast \'Blizzard\' (No Repeat)'),
(16977, 0, 4, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 0, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Arch Mage Xintor - Between 0-15% Health - Flee For Assist (No Repeat)');
