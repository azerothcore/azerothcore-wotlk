-- DB update 2024_03_04_01 -> 2024_03_04_02
--
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (20039, 20045) AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20039, 0, 0, 0, 0, 0, 100, 0, 9700, 12200, 18050, 30950, 0, 0, 11, 37156, 0, 0, 0, 0, 0, 28, 45, 1, 1, 0, 0, 0, 0, 0, 'Phoenix-Hawk - In Combat - Cast Dive'),
(20039, 0, 1, 0, 0, 0, 100, 0, 6450, 9150, 16950, 29050, 0, 0, 11, 37159, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix-Hawk - In Combat - Cast Mana Burn'),
(20045, 0, 0, 0, 0, 0, 100, 0, 11900, 11900, 19300, 19300, 0, 0, 11, 37135, 128, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nether Scryer - In Combat - Cast \'Domination\''),
(20045, 0, 1, 0, 0, 0, 100, 0, 12400, 14900, 9800, 9800, 0, 0, 11, 37126, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Nether Scryer - In Combat - Cast \'Arcane Blast\'');
