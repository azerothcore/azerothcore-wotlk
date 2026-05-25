-- DB update 2024_11_08_00 -> 2024_11_09_00
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 43149;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(43149, 'spell_claw_rage_aura');

UPDATE `creature_template` SET `unit_flags` = `unit_flags` |2 WHERE `entry` IN (23878, 23880, 23877, 23879);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 42542;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 42542, 0, 0, 31, 0, 3, 23863, 0, 0, 0, 0, '', 'Cosmetic - Zul\'Aman Spirit Drain can only target Zul\'jin');
