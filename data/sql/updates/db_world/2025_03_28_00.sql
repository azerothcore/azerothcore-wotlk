-- DB update 2025_03_27_01 -> 2025_03_28_00

-- Add Condition to use Scarlet Cannons
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 18) AND (`SourceGroup` = 28833) AND (`SourceEntry` = 52447) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 9) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 12701) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(18, 28833, 52447, 0, 0, 9, 0, 12701, 0, 0, 0, 0, 0, '', 'Scarlet Cannon spellclick require Massacre at Light’s Point quest taken');
