INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1559215442284268490');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceGroup` = 0 AND `SourceEntry` = 55818 AND `ConditionTypeOrReference` = 31 AND `ConditionValue2` = 29503;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES
(17,0,55818,0,1,31,1,3,29503,0,0,0,0,'','Requires Fjorn');
