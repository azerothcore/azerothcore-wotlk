-- DB update 2025_01_12_01 -> 2025_01_13_00
--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 18) AND (`SourceEntry` = 52263);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(18, 28605, 52263, 0, 0, 9, 0, 12680, 0, 0, 0, 0, 0, '', 'Havenshire Stallion spellclick require Grand Theft Palomino quest taken'),
(18, 28606, 52263, 0, 0, 9, 0, 12680, 0, 0, 0, 0, 0, '', 'Havenshire Mare spellclick require Grand Theft Palomino quest taken'),
(18, 28607, 52263, 0, 0, 9, 0, 12680, 0, 0, 0, 0, 0, '', 'Havenshire Colt spellclick require Grand Theft Palomino quest taken');
