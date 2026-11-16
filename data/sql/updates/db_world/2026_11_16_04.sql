-- DB update 2026_11_16_03 -> 2026_11_16_04
--
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 66339;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 66339, 0, 0, 31, 0, 3, 34862, 0, 0, 0, 0, '', 'Target for Anub\'arak Summon Scarab'),
(13, 1, 66339, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Target for Anub\'arak Summon Scarab');

DELETE FROM `spell_script_names` WHERE `spell_id` = 66339;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(66339, 'spell_anubarak_summon_scarab_aura');
