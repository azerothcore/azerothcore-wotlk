-- DB update 2023_08_25_02 -> 2023_08_30_00
-- Table Condition - Fix Quests - 8353 - 8355 - 8356 - 8357 - 8311 --

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 19) AND (`SourceGroup` = 0) AND (`SourceEntry` IN (8353, 8355, 8356, 8357, 8311)) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 12) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 12) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 19) AND (`SourceGroup` = 0) AND (`SourceEntry` IN (8353, 8355, 8356, 8357)) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 47) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 8311) AND (`ConditionValue2` = 64) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 8356, 0, 0, 47, 0, 8311, 64, 0, 1, 0, 0, '', 'Prevents quest from being available after completing quest Hallows End Treats for Jespers'),
(19, 0, 8355, 0, 0, 47, 0, 8311, 64, 0, 1, 0, 0, '', 'Prevents quest from being available after completing quest Hallows End Treats for Jespers'),
(19, 0, 8353, 0, 0, 47, 0, 8311, 64, 0, 1, 0, 0, '', 'Prevents quest from being available after completing quest Hallows End Treats for Jespers'),
(19, 0, 8357, 0, 0, 47, 0, 8311, 64, 0, 1, 0, 0, '', 'Prevents quest from being available after completing quest Hallows End Treats for Jespers');
