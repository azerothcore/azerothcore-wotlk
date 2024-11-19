-- DB update 2022_08_16_00 -> 2022_08_19_00
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 1) AND (`SourceGroup` IN (11448, 11450, 11444, 14321, 14326, 14323, 11441, 14351, 11445, 14325)) AND (`SourceEntry` = 18250) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 2) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 18250) AND (`ConditionValue2` = 1) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(1, 14325, 18250, 0, 0, 2, 0, 18250, 1, 0, 1, 0, 0, '', "Gordok key drop requires not having Gordok Key"),
(1, 14321, 18250, 0, 0, 2, 0, 18250, 1, 0, 1, 0, 0, '', "Gordok key drop requires not having Gordok Key"),
(1, 14326, 18250, 0, 0, 2, 0, 18250, 1, 0, 1, 0, 0, '', "Gordok key drop requires not having Gordok Key"),
(1, 14323, 18250, 0, 0, 2, 0, 18250, 1, 0, 1, 0, 0, '', "Gordok key drop requires not having Gordok Key"),
(1, 11441, 18250, 0, 0, 2, 0, 18250, 1, 0, 1, 0, 0, '', "Gordok key drop requires not having Gordok Key"),
(1, 14351, 18250, 0, 0, 2, 0, 18250, 1, 0, 1, 0, 0, '', "Gordok key drop requires not having Gordok Key"),
(1, 11445, 18250, 0, 0, 2, 0, 18250, 1, 0, 1, 0, 0, '', "Gordok key drop requires not having Gordok Key"),
(1, 11444, 18250, 0, 0, 2, 0, 18250, 1, 0, 1, 0, 0, '', "Gordok key drop requires not having Gordok Key"),
(1, 11450, 18250, 0, 0, 2, 0, 18250, 1, 0, 1, 0, 0, '', "Gordok key drop requires not having Gordok Key"),
(1, 11448, 18250, 0, 0, 2, 0, 18250, 1, 0, 1, 0, 0, '', "Gordok key drop requires not having Gordok Key");
