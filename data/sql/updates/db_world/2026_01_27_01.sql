-- DB update 2026_01_27_00 -> 2026_01_27_01
-- Updates the trainer option from "Train me." to "I seek training in Fishing."
UPDATE `gossip_menu_option` SET `OptionText` = 'I seek training in Fishing.', `OptionBroadcastTextID` = 34245 WHERE `MenuID` = 10437 AND `OptionID` = 0;

-- Adds "I would like to buy from you." to gossip menu. Can't parse sniff to validate which 1 out of 5 "I would like to buy from you." is the correct one.
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 10437 AND `OptionID` = 1;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(10437, 1, 1, 'I would like to buy from you.', 9992, 3, 128, 0, 0, 0, 0, '', 0, 0);
