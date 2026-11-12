-- DB update 2026_10_13_04 -> 2026_10_13_05
--
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 19 AND `SourceGroup` = 0 AND `SourceEntry` = 10919 AND `SourceId` = 0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 10919, 0, 0, 9, 0, 10916, 0, 0, 0, 0, 0, '', 'Show quest \'Fei Fei\'s Treat\' only if quest \'Digging for Prayer Beads\' is accepted but not completed');
