INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640037227067484700');

-- Removing duplicated un-used quest
DELETE FROM `quest_template` WHERE (`ID` = 960);

-- Turning quest 'Onu is Meditating' to auto-complete
UPDATE `quest_template` SET `Flags` = `Flags`| 65536 WHERE (`ID` = 961);

-- Adding conditions to quest: 'Onu is Meditating'
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 19) AND (`SourceGroup` = 0) AND (`SourceEntry` = 961) AND (`ConditionTypeOrReference` = 47) AND (`ConditionValue1` = 944) AND (`ConditionValue2` = 10);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 961, 0, 0, 47, 0, 944, 10, 0, 0, 0, 0, '', 'When quest \'The Master\'s Glaive\' state In-progress show \'Onu is Meditating\'');
