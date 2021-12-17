INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639776045356880700');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=181045 AND `SourceGroup` IN (1, 5);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(22, 1, 181045, 1, 0, 29, 1, 16044, 30, 0, 0, 0, 0, '', 'Brazier of Beckoning only run SAI if Mor Grayhoof Trigger is near'),
(22, 5, 181045, 1, 0, 29, 1, 16048, 30, 0, 0, 0, 0, '', 'Brazier of Beckoning only run SAI if Lord Vathalak Trigger is near');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=181051 AND `SourceGroup` IN (1, 5);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(22, 1, 181051, 1, 0, 29, 1, 16044, 30, 0, 0, 0, 0, '', 'Brazier of Invocation only run SAI if Mor Grayhoof Trigger is near'),
(22, 5, 181051, 1, 0, 29, 1, 16048, 30, 0, 0, 0, 0, '', 'Brazier of Invocation only run SAI if Lord Vathalak Trigger is near');
