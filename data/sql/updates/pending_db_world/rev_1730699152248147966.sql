UPDATE `creature` SET `id1` = 17400 WHERE `guid` IN (138247, 138248, 138249, 138250, 138252, 138253);

INSERT INTO `conditions` 
(`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) 
VALUES 
(22, 6, 17371, 0, 1, 29, 1, 17400, 10, 0, 0, 0, 0, '', 'Only cast Fel Power (33111) if a Felguard Annihilator (17400) is nearby');
