-- DB update 2023_04_19_33 -> 2023_04_19_34
-- Rathis Tomber (16224)
DELETE FROM `gossip_menu` WHERE `MenuID` = 7162 AND `TextID` = 8432;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(7162, 8432);

UPDATE `conditions` SET `Comment` = 'Rathis Tomber - Show Option 0 (Vendor) if quest 9152 has been rewarded.' WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 7162 AND `SourceEntry` = 0;

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 14 AND `SourceGroup` = 7162;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 7162, 8432, 0, 0, 8, 0, 9152, 0, 0, 0, 0, 0, '', 'Rathis Tomber - Show gossip text 8432 if quest 9152 has been rewarded.');
