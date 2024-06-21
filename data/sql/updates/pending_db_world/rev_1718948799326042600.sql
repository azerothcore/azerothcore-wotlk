-- Refik
DELETE FROM `gossip_menu` WHERE `MenuID` = 8868 and `TextID` = 10652;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(8868, 10652);

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 8868) AND (`SourceEntry` = 11551);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 8868, 11551, 0, 0, 7, 0, 197, 200, 0, 0, 0, 0, '', 'Show npctext 11551 for Refik if the player\'s tailoring skill is over 200.');
