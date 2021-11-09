INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636427747651853200');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceEntry` = 15958;
INSERT INTO `conditions`(`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 15958, 0, 0, 30, 0, 175124, 5, 0, 0, 0, 0, '', 'Collect Rookery Egg require near GO Rookery Egg');
