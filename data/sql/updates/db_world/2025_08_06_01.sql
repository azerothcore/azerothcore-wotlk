-- DB update 2025_08_06_00 -> 2025_08_06_01

-- Set flag Only Swim (sniffed flags)
UPDATE `creature_template` SET `unit_flags` = `unit_flags`|32768 WHERE (`entry` = 25479);

-- Remove Swim and Flight flags
UPDATE `creature_template_movement` SET `Swim` = 0, `Flight` = 0 WHERE (`CreatureId` = 25479);

-- Set SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25479;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25479);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25479, 0, 0, 0, 0, 0, 100, 0, 2000, 3000, 9000, 11000, 0, 0, 11, 49816, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Kvaldir Mistweaver - In Combat - Cast \'Mist of Strangulation\''),
(25479, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kvaldir Mistweaver - On Aggro - Set Fly Off'),
(25479, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 60, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kvaldir Mistweaver - On Reset - Set Fly On');
