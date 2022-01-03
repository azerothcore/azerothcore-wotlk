INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640651539577989000');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 19) AND (`SourceGroup` = 0) AND (`SourceEntry` IN (7483, 7484, 7485)) AND (`SourceId` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 7483, 0, 1, 8, 0, 7482, 0, 0, 0, 0, 0, '', 'Libram of Rapidity - Available only if Elven Legends (Alliance) is completed'),
(19, 0, 7484, 0, 1, 8, 0, 7482, 0, 0, 0, 0, 0, '', 'Libram of Focus - Available only if Elven Legends (Alliance) is completed'),
(19, 0, 7485, 0, 1, 8, 0, 7482, 0, 0, 0, 0, 0, '', 'Libram of Protection - Available only if Elven Legends (Alliance) is completed'),
(19, 0, 7483, 0, 2, 8, 0, 7481, 0, 0, 0, 0, 0, '', 'Libram of Rapidity - Available only if Elven Legends (Horde) is completed'),
(19, 0, 7484, 0, 2, 8, 0, 7481, 0, 0, 0, 0, 0, '', 'Libram of Focus - Available only if Elven Legends (Horde) is completed'),
(19, 0, 7485, 0, 2, 8, 0, 7481, 0, 0, 0, 0, 0, '', 'Libram of Protection - Available only if Elven Legends (Horde) is completed');
