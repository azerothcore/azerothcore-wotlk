-- DB update 2023_11_08_05 -> 2023_11_08_06
-- Torgos!
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 37065);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 37065, 0, 0, 29, 0, 18707, 100, 0, 0, 0, 0, '', 'Allow using \'Trachela\'s Carcass\' only if \'Torgos\' is alive and within 100y.');
