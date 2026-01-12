-- DB update 2025_12_01_02 -> 2025_12_01_03
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 52457;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 52457, 0, 0, 31, 0, 3, 26797, 0, 0, 0, 0, '', 'Spell 52457 (Drak\'aguul\'s Soldiers) - Target Drakkari Protector'),
(13, 1, 52457, 0, 1, 31, 0, 3, 26795, 0, 0, 0, 0, '', 'Spell 52457 (Drak\'aguul\'s Soldiers) - Target Drakkari Oracle');
