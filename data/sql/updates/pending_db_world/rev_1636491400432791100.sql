INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636491400432791100');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 1) AND (`SourceGroup` IN (2764, 2765, 4063)) AND (`SourceEntry` = 21525);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(1, 2764, 21525, 0, 0, 12, 0, 2, 0, 0, 0, 0, 0, '', ''),
(1, 2765, 21525, 0, 0, 12, 0, 2, 0, 0, 0, 0, 0, '', ''),
(1, 4063, 21525, 0, 0, 12, 0, 2, 0, 0, 0, 0, 0, '', '');