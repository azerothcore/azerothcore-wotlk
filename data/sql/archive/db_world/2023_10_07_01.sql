-- DB update 2023_10_07_00 -> 2023_10_07_01
-- Lord Valthalak's Amulet
DELETE FROM `spell_script_names` WHERE `spell_id`=27360;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (27360, 'spell_gen_valthalak_amulet');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceGroup` = 0 AND `SourceEntry` = 27360;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 27360, 0, 0, 29, 0, 16073, 50, 0, 1, 0, 0, '', 'Allow using Lord Valthalak\'s Amulet only if there is no Spirit of Lord Valthalak within 50 yards.');
