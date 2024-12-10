-- DB update 2023_10_18_02 -> 2023_10_20_00
--
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 19 AND `SourceGroup` = 0 AND `SourceEntry` IN (10024,10017);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 10024, 0, 0, 5, 0, 934, 7, 0, 0, 0, 0, '', 'Show quest \'Voren\'thal\'s Visions\' only if the player is unfriendly or lower towards The Scryers.'),
(19, 0, 10017, 0, 0, 5, 0, 932, 7, 0, 0, 0, 0, '', 'Show quest \'Strained Supplies\' only if the player is unfriendly or lower towards The Aldor.');
