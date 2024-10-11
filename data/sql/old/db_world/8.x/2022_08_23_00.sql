-- DB update 2022_08_21_19 -> 2022_08_23_00
--
UPDATE `creature` SET `spawntimesecs` = 120 WHERE `id1` = 15514;

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 29) AND (`SourceEntry` = 15514) AND (`SourceId` = 0) AND (`ConditionTypeOrReference` = 13);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(29, 0, 15514, 0, 0, 13, 0, 16, 2, 0, 1, 0, 0, '', 'Buru Egg spawn only if Buru is in egg phase.');
