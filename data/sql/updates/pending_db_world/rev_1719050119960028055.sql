--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceEntry` = 16609);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 7, 16609, 0, 0, 6, 0, 67, 0, 0, 0, 0, 0, '', 'Warchief\'s Blessing - Player must be Horde'),
(13, 7, 16609, 0, 0, 27, 0, 63, 4, 0, 0, 0, 0, '', 'Warchief\'s Blessing - Player must be level 63 or lower'),
(13, 7, 16609, 0, 0, 5, 0, 76, 240, 0, 0, 0, 0, '', 'Warchief\'s Blessing - Player must be at least Friendly with Orgrimmar');
