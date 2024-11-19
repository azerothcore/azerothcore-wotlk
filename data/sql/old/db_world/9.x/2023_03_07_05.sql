-- DB update 2023_03_07_04 -> 2023_03_07_05
-- Chimaerok
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 12800);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(12800, 0, 0, 0, 0, 0, 100, 512, 12000, 15000, 12000, 15000, 0, 11, 20629, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Chimaerok - In Combat - Cast \'Corrosive Venom Spit\''),
(12800, 0, 1, 0, 0, 0, 100, 512, 2000, 4000, 3000, 4000, 0, 11, 20627, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Chimaerok - In Combat - Cast \'Lightning Breath\''),
(12800, 0, 2, 0, 0, 0, 100, 512, 10000, 15000, 10000, 15000, 0, 11, 18144, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Chimaerok - In Combat - Cast \'Swoop\'');
