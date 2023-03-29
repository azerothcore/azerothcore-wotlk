--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceEntry` = 35301) AND (`ConditionTypeOrReference` = 31) AND (`ConditionValue2` = 21062);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 35301, 0, 0, 31, 0, 3, 21062, 0, 0, 0, 0, '', 'Spell Suicide (35301) only targets Nether Wraith (21062)');
