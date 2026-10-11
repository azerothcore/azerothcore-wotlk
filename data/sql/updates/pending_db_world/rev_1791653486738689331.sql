--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 46222) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 4) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 46222, 0, 0, 31, 0, 4, 0, 0, 1, 0, 0, '', 'target must not be a player');
