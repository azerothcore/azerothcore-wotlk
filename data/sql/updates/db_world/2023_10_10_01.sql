-- DB update 2023_10_10_00 -> 2023_10_10_01
-- Place Draenei Banner
UPDATE `conditions` SET `Comment` = '\'Place Draenei Banner\' - Target only Lord Xiz' WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 30988) AND (`ConditionTypeOrReference` = 31) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 17701);
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 30988) AND (`ConditionTypeOrReference` = 29) AND (`ConditionValue1` = 17701) AND (`ConditionValue2` = 5) AND (`ConditionValue3` = 1);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 30988, 0, 0, 29, 0, 17701, 5, 1, 0, 0, 0, '', 'Allow casting \'Place Draenei Banner\' only if Lord Xiz is within 5 yards and dead.');
