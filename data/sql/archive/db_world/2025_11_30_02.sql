-- DB update 2025_11_30_01 -> 2025_11_30_02

-- Event occours only if a player dismount.
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 6) AND (`SourceEntry` = 27587) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 32) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 16) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 6, 27587, 0, 0, 32, 0, 16, 0, 0, 0, 0, 0, '', 'Event occours only if a player dismount.');
