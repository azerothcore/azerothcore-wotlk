-- DB update 2026_10_10_10 -> 2026_10_10_11
--
UPDATE `gossip_menu_option` SET `OptionText` = 'Send me to the Abyssal Shelf!' WHERE `MenuID` = 8096 AND `OptionID` = 0;
UPDATE `gossip_menu_option` SET `OptionText` = 'Send me to Honor Point!' WHERE `MenuID` = 8096 AND `OptionID` = 1;

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 8096 AND `SourceEntry` = 1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 8096, 1, 0, 0, 47, 0, 10382, 74, 0, 0, 0, 0, '', 'Gryphoneer Windbellow - Show gossip option 1 if quest Go to the Front (10382) is taken, completed or rewarded');
