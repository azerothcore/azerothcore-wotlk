-- DB update 2025_12_18_07 -> 2025_12_19_00
--
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 18 AND `SourceGroup` IN (29433, 29555) AND `SourceEntry` = 47020;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(18, 29433, 47020, 0, 0, 31, 0, 3, 0, 0, 0, 0, 0, '', 'Only Backpacks can mount Goblin Sappers'),
(18, 29555, 47020, 0, 0, 31, 0, 3, 0, 0, 0, 0, 0, '', 'Only Backpacks can mount Goblin Sappers');
