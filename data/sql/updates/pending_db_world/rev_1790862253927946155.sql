--
-- Prevent cone cast of Scorch targeting players in Ignis' Slag Pot
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` IN (62549, 62553, 63475)) AND (`SourceId` = 0) AND (`ElseGroup` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 62549, 0, 0, 1, 0, 62717, 1, 0, 1, 0, 0, '', 'target must not have aura \'Slag Pot\''),
(13, 1, 62553, 0, 0, 1, 0, 62717, 1, 0, 1, 0, 0, '', 'target must not have aura \'Slag Pot\''),
(13, 1, 63475, 0, 0, 1, 0, 62717, 1, 0, 1, 0, 0, '', 'target must not have aura \'Slag Pot\'');
