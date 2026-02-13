-- DB update 2026_01_09_01 -> 2026_01_10_00
--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 49266) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 1) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 49282) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 49266, 0, 0, 1, 1, 49282, 0, 0, 1, 0, 0, '', 'Mounting Up (12414): Dangle Wild Carrot (49266) cannot be cast on a horse that is already mounted with Ride Highland Mustang (49282)');
