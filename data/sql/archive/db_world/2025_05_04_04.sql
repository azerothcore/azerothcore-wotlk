-- DB update 2025_05_04_03 -> 2025_05_04_04
--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 18) AND (`SourceGroup` = 27061) AND (`SourceEntry` = 47920);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(18, 27061, 47920, 0, 0, 9, 0, 12050, 0, 0, 0, 0, 0, '', 'Allow interaction only while on quest \'Lumber Hack!\''),
(18, 27061, 47920, 0, 1, 9, 0, 12052, 0, 0, 0, 0, 0, '', 'Allow interaction only while on quest \'Harp on This!\'');
