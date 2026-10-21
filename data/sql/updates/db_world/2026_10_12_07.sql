-- DB update 2026_10_12_06 -> 2026_10_12_07
--
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 1323 AND `SourceEntry` = 2;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 1323, 2, 0, 0, 2, 0, 10515, 1, 1, 1, 0, 0, '', 'Kalaran Windblade - Show gossip option if player does not have item 10515'),
(15, 1323, 2, 0, 0, 8, 0, 3454, 0, 0, 0, 0, 0, '', 'Kalaran Windblade - Show gossip option if player has quest 3454 rewarded');
