-- DB update 2025_09_03_01 -> 2025_09_03_02
--
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (16423, 16437, 16438, 16422);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (16423, 16437, 16438, 16422);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16423, 0, 0, 0, 0, 0, 100, 0, 0, 0, 5000, 10000, 0, 0, 11, 28265, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Spectral Apparition - In Combat - Cast \'Scourge Strike\''),
(16437, 0, 0, 0, 0, 0, 100, 0, 0, 0, 5000, 10000, 0, 0, 11, 28265, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Spectral Spirit - In Combat - Cast \'Scourge Strike\''),
(16422, 0, 0, 0, 0, 0, 100, 0, 0, 0, 5000, 10000, 0, 0, 11, 28265, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Soldier - In Combat - Cast \'Scourge Strike\''),
(16438, 0, 0, 0, 0, 0, 100, 0, 0, 0, 5000, 10000, 0, 0, 11, 28265, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Trooper - In Combat - Cast \'Scourge Strike\'');
