-- DB update 2026_10_24_04 -> 2026_10_24_05
--
DELETE FROM `gossip_menu` WHERE `MenuID` = 8532 AND `TextID` = 10674;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(8532, 10674);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 14 AND `SourceGroup` = 8532 AND `SourceEntry` = 10674;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 8532, 10674, 0, 0, 7, 0, 197, 1, 0, 1, 0, 0, '', 'Andrion Darkspinner - Show gossip text 10674 if player does not have Tailoring');
