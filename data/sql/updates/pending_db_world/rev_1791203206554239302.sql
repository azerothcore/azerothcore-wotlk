--
UPDATE `spell_scripts` SET `datalong` = 37895 WHERE (`id` = 37894) AND (`effIndex` = 0) AND (`command` = 15) AND (`datalong` = 37893);

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` IN (37868, 37893, 37895)) AND (`SourceId` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 37868, 0, 0, 31, 0, 3, 21909, 1976587, 0, 0, 0, '', 'Arcano-Scorp Control - Target the Arcano-Scorp of its control unit'),
(13, 1, 37893, 0, 0, 31, 0, 3, 21909, 1976586, 0, 0, 0, '', 'Arcano-Scorp Control - Target the Arcano-Scorp of its control unit'),
(13, 1, 37895, 0, 0, 31, 0, 3, 21909, 76655, 0, 0, 0, '', 'Arcano-Scorp Control - Target the Arcano-Scorp of its control unit');

UPDATE `creature` SET `wander_distance` = 0, `MovementType` = 0 WHERE (`id` = 21909) AND (`guid` IN (76655, 1976586, 1976587));
