-- DB update 2022_07_20_08 -> 2022_07_20_09
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 12119;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 12119) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(12119, 0, 0, 0, 0, 0, 100, 0, 5000, 5000, 6500, 6500, 0, 11, 20604, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Flamewaker Protector - In Combat - Cast \'Dominate Mind\''),
(12119, 0, 1, 0, 0, 0, 100, 0, 5000, 10000, 7000, 7000, 0, 11, 20605, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Flamewaker Protector - In Combat - Cast \'Cleave\'');
