-- DB update 2023_04_17_00 -> 2023_04_17_01
--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 33332);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 33332, 0, 1, 31, 0, 3, 18639, 0, 0, 0, 0, '', 'Suppression Blast (33332) can only target a set of Entries'),
(13, 1, 33332, 0, 2, 31, 0, 3, 18634, 0, 0, 0, 0, '', 'Suppression Blast (33332) can only target a set of Entries'),
(13, 1, 33332, 0, 3, 31, 0, 3, 18632, 0, 0, 0, 0, '', 'Suppression Blast (33332) can only target a set of Entries');
