-- DB update 2025_08_24_00 -> 2025_08_25_00
--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 4) AND (`SourceGroup` = 193997) AND (`SourceEntry` = 44725) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 5) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 1119) AND (`ConditionValue2` = 16) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(4, 26782, 44725, 0, 0, 5, 0, 1119, 240, 0, 0, 0, 0, '', 'Everfrost Chip requires Sons of Hodir friendly');
