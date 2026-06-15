-- DB update 2026_05_23_00 -> 2026_05_24_00
--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 4) AND (`SourceEntry` = 30886);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 4, 30886, 0, 0, 23, 1, 4526, 0, 0, 1, 0, 0, '', 'Despawn Subjugated Iskalder when outside quest areas'),
(22, 4, 30886, 0, 0, 23, 1, 4498, 0, 0, 1, 0, 0, '', 'Despawn Subjugated Iskalder when outside quest areas'),
(22, 4, 30886, 0, 0, 23, 1, 4496, 0, 0, 1, 0, 0, '', 'Despawn Subjugated Iskalder when outside quest areas');
