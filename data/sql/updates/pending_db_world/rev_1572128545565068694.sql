INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1572128545565068694');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 1 AND `SourceGroup` = 30160 AND `SourceEntry` = 42246 AND `ConditionTypeOrReference` = 9;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES
(1,30160,42246,0,0,9,0,12981,0,0,0,0,0,'','Can only loot ''Essence of Ice'' if quest ''Hot and Cold'' taken');
