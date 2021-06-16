INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623836040397308600');
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 3701) AND (`SourceEntry` = 0) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 47) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 5727) AND (`ConditionValue2` = 8) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 3701, 0, 0, 0, 47, 0, 5727, 8, 0, 0, 0, 0, '', '');
