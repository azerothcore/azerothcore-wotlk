-- DB update 2025_06_18_00 -> 2025_06_21_00

-- Add Condition "Player should be within 5 yard of Salanar".
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 52264) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 29) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 28653) AND (`ConditionValue2` = 5) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 52264, 0, 0, 29, 0, 28653, 5, 0, 0, 0, 0, '', 'Deliver Stolen Horse only near Salanar the Horseman');
