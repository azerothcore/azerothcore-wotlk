-- DB update 2022_08_19_00 -> 2022_08_21_00
-- 
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15461;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15461) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15461, 0, 0, 0, 0, 0, 100, 0, 7200, 20600, 10900, 19400, 0, 11, 22886, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Shrieker Scarab - In Combat - Cast \'Berserker Charge\''),
(15461, 0, 1, 0, 0, 0, 100, 0, 7200, 14500, 12100, 20600, 0, 11, 26379, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shrieker Scarab - In Combat - Cast \'Piercing Shriek\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15462;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15462) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15462, 0, 0, 0, 0, 0, 100, 0, 15600, 18200, 14600, 20600, 0, 11, 22886, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Spitting Scarab - In Combat - Cast \'Berserker Charge\''),
(15462, 0, 1, 0, 0, 0, 100, 0, 7200, 16900, 9700, 19400, 0, 11, 24334, 4, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Spitting Scarab - In Combat - Cast \'Acid Spit\'');
