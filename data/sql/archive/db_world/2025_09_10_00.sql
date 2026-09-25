-- DB update 2025_09_09_05 -> 2025_09_10_00
--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 18) AND (`SourceGroup` = 25334) AND (`SourceEntry` IN (47917, 46598)) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 9) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 11652) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(18, 25334, 47917, 0, 0, 9, 0, 11652, 0, 0, 0, 0, 0, '', 'Horde Siege Tank requires player to be on quest The Plains of Nasam'),
(18, 25334, 46598, 0, 0, 9, 0, 11652, 0, 0, 0, 0, 0, '', 'Horde Siege Tank requires player to be on quest The Plains of Nasam');
