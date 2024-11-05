-- New Year Celebrations!
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 19) AND (`SourceGroup` = 0) AND `SourceEntry` IN (8860,8861);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 8860, 0, 0, 12, 0, 6, 0, 0, 0, 0, 0, '', 'Show quest \'New Year Celebrations!\' (A) only on New Year\'s Eve'),
(19, 0, 8861, 0, 0, 12, 0, 6, 0, 0, 0, 0, 0, '', 'Show quest \'New Year Celebrations!\' (H) only on New Year\'s Eve');
