-- DB update 2022_08_15_04 -> 2022_08_15_05
-- 
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1491;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 1491) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1491, 0, 0, 0, 0, 0, 100, 512, 3000, 6000, 7000, 8000, 0, 11, 9080, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Zanzil Naga - In Combat - Cast \'Hamstring\''),
(1491, 0, 1, 0, 0, 0, 100, 512, 4000, 5000, 10000, 11000, 0, 11, 12555, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Zanzil Naga - In Combat - Cast \'Pummel\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1488;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 1488) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1488, 0, 0, 0, 0, 0, 100, 513, 2000, 3000, 0, 0, 0, 11, 7102, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Zanzil Zombie - In Combat - Cast \'Contagion of Rot\' (No Repeat)');
