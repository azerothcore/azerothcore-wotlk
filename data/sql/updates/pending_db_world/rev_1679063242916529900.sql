--
DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 62000);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(62000, 0, 0, 'Hand over the Southfury moonstone and I\'ll let you go.', 0, 1, 1, 0, 0, 0, 0, '', 0, 0);


DELETE FROM `gossip_menu` WHERE (`MenuID` = 62000);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(62000, 68);


UPDATE `creature_template` SET `npcflag` = 1 WHERE (`entry` = 23002);
