-- DB update 2024_11_24_06 -> 2024_11_24_07
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28576;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28576) AND (`source_type` = 0) AND (`id` IN (8));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28576, 0, 8, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 86, 58207, 0, 10, 128581, 28765, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of Havenshire - On Aggro - Cross Cast \'Lich King VO Blocker\'');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 28576 AND `SourceId` = 0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES 
(22, 9, 28576, 0, 0, 14, 0, 12678, 0, 0, 1, 'Action invoker has finished or active quest If Chaos Drives, Let Suffering Hold The Reins (12678)');

DELETE
FROM `spell_script_names`
WHERE `spell_id` BETWEEN 58207 AND 58223;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(58207, 'spell_lich_king_vo_blocker'),
(58208, 'spell_lich_king_whisper'),
(58209, 'spell_lich_king_whisper'),
(58210, 'spell_lich_king_whisper'),
(58211, 'spell_lich_king_whisper'),
(58212, 'spell_lich_king_whisper'),
(58213, 'spell_lich_king_whisper'),
(58214, 'spell_lich_king_whisper'),
(58215, 'spell_lich_king_whisper'),
(58216, 'spell_lich_king_whisper'),
(58217, 'spell_lich_king_whisper'),
(58218, 'spell_lich_king_whisper'),
(58219, 'spell_lich_king_whisper'),
(58220, 'spell_lich_king_whisper'),
(58221, 'spell_lich_king_whisper'),
(58222, 'spell_lich_king_whisper'),
(58223, 'spell_lich_king_whisper');
