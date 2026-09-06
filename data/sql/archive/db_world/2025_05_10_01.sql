-- DB update 2025_05_10_00 -> 2025_05_10_01
--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 19) AND (`SourceGroup` = 0) AND (`SourceEntry` = 12821) AND (`ConditionValue1` IN (12820,12832));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 12821, 0, 0, 8, 0, 12820, 0, 0, 0, 0, 0, '', 'Allow picking quest \'Opening the Backdoor\' only if \'A Delicate Touch\' has been completed.'),
(19, 0, 12821, 0, 0, 8, 0, 12832, 0, 0, 0, 0, 0, '', 'Allow picking quest \'Opening the Backdoor\' only if \'Bitter Departure\' has been completed.');
