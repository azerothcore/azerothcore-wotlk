-- DB update 2024_11_13_02 -> 2024_11_13_03
UPDATE `creature` SET `id1` = 17400 WHERE `guid` IN (138247, 138248, 138249, 138250, 138252, 138253);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceGroup` = 6 AND `SourceEntry` = 17371 AND `ConditionValue1` = 17400;
INSERT INTO `conditions` 
(`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) 
VALUES 
(22, 6, 17371, 0, 1, 29, 1, 17400, 10, 0, 0, 0, 0, '', 'Only cast Fel Power (33111) if a Felguard Annihilator (17400) is nearby');
