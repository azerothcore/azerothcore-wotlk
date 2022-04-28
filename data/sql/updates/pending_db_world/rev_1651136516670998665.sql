INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1651136516670998665');
-- nekrums medallion should drop only when on quest 9471
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 9471);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(1, 9471, 9471, 0, 0, 9, 0, 2991, 0, 0, 0, 0, 0, '', NULL);
