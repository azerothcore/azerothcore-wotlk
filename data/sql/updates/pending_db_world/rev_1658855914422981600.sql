--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` IN (25177, 25178, 25180, 25181, 25183)) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 15339) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 25177, 0, 0, 31, 1, 3, 15339, 0, 0, 0, 0, '', 'Fire Weakness should only affect Ossirian'),
(17, 0, 25178, 0, 0, 31, 1, 3, 15339, 0, 0, 0, 0, '', 'Frost Weakness should only affect Ossirian'),
(17, 0, 25180, 0, 0, 31, 1, 3, 15339, 0, 0, 0, 0, '', 'Nature Weakness should only affect Ossirian'),
(17, 0, 25181, 0, 0, 31, 1, 3, 15339, 0, 0, 0, 0, '', 'Arcane Weakness should only affect Ossirian'),
(17, 0, 25183, 0, 0, 31, 1, 3, 15339, 0, 0, 0, 0, '', 'Shadow Weakness should only affect Ossirian');
