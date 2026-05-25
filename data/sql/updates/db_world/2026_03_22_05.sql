-- DB update 2026_03_22_04 -> 2026_03_22_05
--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 11) AND (`SourceEntry` = 21838) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 29) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 23377) AND (`ConditionValue2` = 90) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 11, 21838, 0, 0, 29, 1, 23377, 90, 0, 0, 0, 0, '', 'Terokk will only Despawn on Evade if Skyguard Ace is nearby.');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 12) AND (`SourceEntry` = 21838) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 29) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 23377) AND (`ConditionValue2` = 90) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 12, 21838, 0, 0, 29, 1, 23377, 90, 0, 0, 0, 0, '', 'Terokk will only Despawn on Evade if Skyguard Ace is nearby.');
