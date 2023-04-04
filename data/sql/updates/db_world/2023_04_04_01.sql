-- DB update 2023_04_04_00 -> 2023_04_04_01
-- Jesse Masters
DELETE FROM `gossip_menu` WHERE `MenuID` = 9798 AND `TextID` = 13502;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(9798, 13502);

DELETE FROM `conditions` WHERE `SourceGroup` = 9798 AND `SourceTypeOrReferenceId` IN (14,15);
DELETE FROM `conditions` WHERE `SourceGroup` = 29244 AND `SourceTypeOrReferenceId` = 23;

INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 9798, 13503, 0, 0, 8, 0, 12212, 0, 0, 0, 0, 0, '', 'Jesse Masters - Show gossip menu 9798 VENDOR only if quest 12212 have been rewarded.'),
(15, 9798, 0, 0, 0, 8, 0, 12212, 0, 0, 0, 0, 0, '', 'Jesse Masters - Show gossip menu 9798 option VENDOR only if quest 12212 have been rewarded.'),
(23, 29244, 40202, 0, 0, 8, 0, 12216, 0, 0, 0, 0, 0, '', 'Jesse Masters - Sell Sizzling Grizzly Flank only if quest 12216 has been rewarded.');
