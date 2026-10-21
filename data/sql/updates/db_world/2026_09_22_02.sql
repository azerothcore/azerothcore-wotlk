-- DB update 2026_09_22_01 -> 2026_09_22_02
-- Ignis casts Kill All Constructs on death. Its implicit target is entry-based, which without a
-- condition matches every unit in range, players included.
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 65109) AND (`SourceId` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 65109, 0, 0, 31, 0, 3, 33121, 0, 0, 0, 0, '', 'Kill All Constructs - Target Iron Construct');
