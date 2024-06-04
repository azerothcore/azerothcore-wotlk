UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28576;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28576) AND (`source_type` = 0) AND (`id` IN (8));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28576, 0, 8, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 86, 58207, 0, 10, 128581, 28765, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of Havenshire - On Aggro - Cross Cast \'Lich King VO Blocker\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28577;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28577) AND (`source_type` = 0) AND (`id` IN (8));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28577, 0, 8, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 86, 58207, 0, 10, 128581, 28765, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of Havenshire - On Aggro - Cross Cast \'Lich King VO Blocker\'');
