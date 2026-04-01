-- DB update 2024_06_22_01 -> 2024_06_22_02
--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 4) AND (`SourceEntry` = 16609) AND (`ConditionTypeOrReference` IN (27,5));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 4, 16609, 0, 0, 27, 0, 63, 4, 0, 0, 0, 0, '', 'Warchief\'s Blessing - Player must be level 63 or lower'),
(13, 4, 16609, 0, 0, 5, 0, 528, 240, 0, 0, 0, 0, '', 'Warchief\'s Blessing - Player must be at least Friendly with Orgrimmar');
