INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1604614793984918900');
-- Pyrobuffet (57557)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=7 AND `SourceEntry`=57557 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=26 AND `ConditionTarget`=0 AND `ConditionValue1`=1 AND `ConditionValue2`=0 AND `ConditionValue3`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 7, 57557, 0, 0, 26, 0, 1, 0, 0, 0, 0, 0, '', 'Pyrobuffet - Target players which has phase mask 1');
