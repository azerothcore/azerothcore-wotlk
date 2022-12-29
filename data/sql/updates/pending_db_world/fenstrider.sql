--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 5) AND (`SourceGroup` = 18134) AND (`SourceEntry` = 24427) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 9) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 9801) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(5, 18134, 24427, 0, 0, 9, 0, 9801, 0, 0, 0, 0, 0, '', 'Fen Strider Tentacle Drop only when on quest: Gathering the Reagents');
