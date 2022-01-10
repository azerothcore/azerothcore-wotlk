INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641824664894549700');

SET @FIRESWORN = 12099;
SET @CORE_HOUND = 11671;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 29 AND `SourceEntry` = @FIRESWORN;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(29, 0, @CORE_HOUND, 0, 0, 13, 0, 2, 1, 3, 1, 0, 0, '', 'Core Hound only spawn if boss state 1 (Magmadar) is not DONE.'),
(29, 0, @FIRESWORN, 0, 0, 13, 0, 2, 3, 3, 1, 0, 0, '', 'Firesworn only spawn if boss state 3 (Garr) is not DONE.');
