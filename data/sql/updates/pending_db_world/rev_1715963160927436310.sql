--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 48649)
AND (`ConditionValue2` IN (15429, 34364, 27914, 37865, 23234, 28267));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 48649, 0, 59, 31, 0, 3, 15429, 0, 0, 0, 0, '', 'Target Non-Combat Pet'),
(13, 1, 48649, 0, 60, 31, 0, 3, 34364, 0, 0, 0, 0, '', 'Target Non-Combat Pet'),
(13, 1, 48649, 0, 61, 31, 0, 3, 27914, 0, 0, 0, 0, '', 'Target Non-Combat Pet'),
(13, 1, 48649, 0, 62, 31, 0, 3, 37865, 0, 0, 0, 0, '', 'Target Non-Combat Pet'),
(13, 1, 48649, 0, 63, 31, 0, 3, 23234, 0, 0, 0, 0, '', 'Target Non-Combat Pet'),
(13, 1, 48649, 0, 64, 31, 0, 3, 28267, 0, 0, 0, 0, '', 'Target Non-Combat Pet');
