-- DB update 2023_02_25_01 -> 2023_02_27_00
--
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceID` = 15 AND `SourceGroup` = 7435;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(15, 7435, 0, 0, 0, 5, 0, 967, 224, 0, 0, 0, 0, '', 'Koren - Show vendor option only if atleast Honored with Violet Eye');
