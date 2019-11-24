INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1572032036915466688');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 24 AND `SourceEntry` IN (48539,48544,48545);
INSERT INTO `conditions`(`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(24, 0, 48539, 0, 0, 1, 1, 70405, 0, 0, 1, 0, 0, '', 'Revitalize (Rank 1) - cannot proc if target has Mutated abomination aura ICC - 10 or 25'),
(24, 0, 48544, 0, 0, 1, 1, 70405, 0, 0, 1, 0, 0, '', 'Revitalize (Rank 2) - cannot proc if target has Mutated abomination aura ICC - 10 or 25'),
(24, 0, 48545, 0, 0, 1, 1, 70405, 0, 0, 1, 0, 0, '', 'Revitalize (Rank 3) - cannot proc if target has Mutated abomination aura ICC - 10 or 25');
