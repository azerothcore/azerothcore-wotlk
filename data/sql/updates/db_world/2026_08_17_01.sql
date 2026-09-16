-- DB update 2026_08_17_00 -> 2026_08_17_01
--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 24) AND (`SourceEntry` = 57688);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(24, 0, 57688, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Focused Anger - proc only from player attacks');
