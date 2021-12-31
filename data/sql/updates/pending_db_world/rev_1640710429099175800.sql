INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640710429099175800');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 19) AND (`SourceGroup` = 0) AND (`SourceEntry` = 3375);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 3375, 0, 0, 2, 0, 7667, 1, 0, 1, 0, 0, '', 'Display quest \'Replacement Vial\' if player lost item (Not in inventory)'),
(19, 0, 3375, 0, 0, 2, 0, 7667, 1, 1, 1, 0, 0, '', 'Display quest \'Replacement Vial\' if player lost item (Not in bank)');
