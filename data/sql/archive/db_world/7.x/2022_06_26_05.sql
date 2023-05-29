-- DB update 2022_06_26_04 -> 2022_06_26_05
--
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14605;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 14605) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14605, 0, 0, 0, 67, 0, 100, 0, 3000, 10000, 0, 0, 0, 11, 8355, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bone Construct - On Behind Target - Cast \'Exploit Weakness\'');
