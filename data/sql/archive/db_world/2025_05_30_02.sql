-- DB update 2025_05_30_01 -> 2025_05_30_02
--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 58152) AND (`SourceId` = 0) AND (`ElseGroup` = 18) AND (`ConditionTypeOrReference` = 31);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 58152, 0, 18, 31, 0, 3, 29321, 0, 0, 0, 0, '', 'Defense System - Arcane Lightning - Ichor Globule');
