-- DB update 2023_11_07_03 -> 2023_11_08_00
-- Naberius
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20483);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20483, 0, 0, 0, 0, 0, 100, 0, 10000, 15000, 25000, 30000, 0, 0, 11, 36146, 128, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Naberius - In Combat - Cast \'Chains of Naberius\' (threatlist > 1)'),
(20483, 0, 1, 0, 0, 0, 100, 0, 1000, 4000, 4000, 4000, 0, 0, 11, 15497, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Naberius - In Combat - Cast \'Frostbolt\''),
(20483, 0, 2, 0, 0, 0, 100, 0, 2000, 5000, 10000, 12000, 0, 0, 11, 36148, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Naberius - In Combat - Cast \'Chill Nova\''),
(20483, 0, 3, 0, 0, 0, 100, 0, 5000, 10000, 15000, 30000, 0, 0, 11, 36147, 0, 0, 0, 0, 0, 5, 60, 1, 0, 0, 0, 0, 0, 0, 'Naberius - In Combat - Cast \'Lesser Shadow Fissure\'');
