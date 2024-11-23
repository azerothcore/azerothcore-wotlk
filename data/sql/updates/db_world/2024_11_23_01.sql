-- DB update 2024_11_23_00 -> 2024_11_23_01
--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` IN (45340, 43962));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 43962, 0, 0, 31, 0, 3, 22515, 0, 0, 0, 0, '', 'Summon Amani\'shi Hatcher target World Trigger'),
(13, 1, 45340, 0, 0, 31, 0, 3, 22515, 0, 0, 0, 0, '', 'Summon Amani\'shi Hatcher target World Trigger');
