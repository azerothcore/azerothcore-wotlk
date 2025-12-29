-- DB update 2024_12_14_00 -> 2024_12_14_01
-- Amani'shi Tempest - Thunderclap ability missing (timers based on timers for same spell)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24549;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 24549) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24549, 0, 0, 0, 0, 0, 100, 0, 5000, 15000, 15000, 30000, 0, 0, 11, 44033, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Tempest - In Combat - Cast \'Thunderclap\'');

-- Amani'shi Warrior - Charge ability missing (timers based on timers for same spell)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24225;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 24225) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24225, 0, 0, 0, 0, 0, 100, 0, 5000, 15000, 20000, 30000, 0, 0, 11, 43519, 0, 0, 0, 0, 0, 5, 0, 1, 0, 0, 0, 0, 0, 0, 'Amani\'shi Warrior - In Combat - Cast \'Charge\'');

-- Amani'shi Protector - Mortal Strike, Piercing Howl, Cleave abilities missing (timers based on timers for same spell)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24180;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 24180) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24180, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 8000, 15000, 0, 0, 11, 43529, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Protector - In Combat - Cast \'Mortal Strike\''),
(24180, 0, 1, 0, 0, 0, 100, 0, 9000, 15000, 15000, 18000, 0, 0, 11, 43530, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Protector - In Combat - Cast \'Piercing Howl\''),
(24180, 0, 2, 0, 0, 0, 100, 0, 3000, 6000, 7000, 12000, 0, 0, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Protector - In Combat - Cast \'Cleave\'');
