-- DB update 2023_08_19_00 -> 2023_08_19_01
--
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_q10651_q10692_book_of_fel_names';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(36298, 'spell_q10651_q10692_book_of_fel_names');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 37906) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 21178) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 37906, 0, 0, 31, 1, 3, 21178, 0, 0, 0, 0, '', 'Book of Fel Names can only target Varedis');
