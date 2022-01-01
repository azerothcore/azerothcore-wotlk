INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640860713284766500');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 29 AND `SourceEntry` = 12101;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(29, 0, 12101, 0, 0, 13, 0, 2, 3, 3, 1, 0, 0, '', 'Lava Surger only spawn if boss state 3 (Garr) is not DONE.');
