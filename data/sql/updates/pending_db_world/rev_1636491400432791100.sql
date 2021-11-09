INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636491400432791100');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 1 AND (`SourceGroup` = 2764) AND (`SourceEntry` = 21525) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 12) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 2) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(1, 2764, 21525, 0, 0, 12, 0, 2, 0, 0, 0, 0, 0, '', ''),
(1, 2765, 21525, 0, 0, 12, 0, 2, 0, 0, 0, 0, 0, '', ''),
(1, 4063, 21525, 0, 0, 12, 0, 2, 0, 0, 0, 0, 0, '', '');
