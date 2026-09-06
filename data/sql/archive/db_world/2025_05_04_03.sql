-- DB update 2025_05_04_02 -> 2025_05_04_03
--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 47939);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 47939, 0, 0, 30, 0, 188539, 5, 0, 0, 0, 0, '', '\'Lumber Hack\' - Limit \'Gather Lumber\' to Coldwind Tree GOs within 5y.');
