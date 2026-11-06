-- DB update 2026_11_03_00 -> 2026_11_03_01
--
-- Sunwell Plateau: Moorba's teleport gossip uses the shifted boss ids (Eredar Twins 3, M'uru 4)
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 9286) AND (`SourceEntry` IN (3, 4, 5)) AND (`SourceId` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 9286, 3, 0, 0, 13, 0, 0, 3, 2, 0, 0, 0, '', 'Show gossip option if Kalecgos done AND Eredar Twins not done'),
(15, 9286, 3, 0, 0, 13, 0, 3, 3, 2, 1, 0, 0, '', 'Show gossip option if Kalecgos done AND Eredar Twins not done'),
(15, 9286, 4, 0, 0, 13, 0, 3, 3, 2, 0, 0, 0, '', 'Show gossip option if Eredar Twins done AND M\'uru not done'),
(15, 9286, 4, 0, 0, 13, 0, 4, 3, 2, 1, 0, 0, '', 'Show gossip option if Eredar Twins done AND M\'uru not done'),
(15, 9286, 5, 0, 0, 13, 0, 4, 3, 2, 0, 0, 0, '', 'Show gossip option if M\'uru done');
