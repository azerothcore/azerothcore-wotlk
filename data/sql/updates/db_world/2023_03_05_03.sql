-- DB update 2023_03_05_02 -> 2023_03_05_03
-- Emberstrife add SAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10321;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 10321);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10321, 0, 0, 0, 0, 0, 100, 0, 2000, 3000, 12000, 14000, 0, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Emberstrife - In Combat - Cast \'Cleave\''),
(10321, 0, 1, 0, 0, 0, 100, 0, 8000, 10000, 25000, 28000, 0, 11, 9573, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Emberstrife - In Combat - Cast \'Flame Breath\''),
(10321, 0, 2, 0, 0, 0, 100, 0, 15000, 18000, 135000, 138000, 0, 11, 8269, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Emberstrife - In Combat - Cast \'Frenzy\''),
(10321, 0, 3, 0, 2, 0, 100, 1, 0, 10, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Emberstrife - Between 0-10% Health - Say Line 0 (No Repeat)');
