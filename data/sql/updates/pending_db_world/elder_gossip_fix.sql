DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (6815) AND `OptionID`=4;
DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (6899) AND `OptionID` IN (1,2);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `ActionMenuID`, `ActionPoiID`) VALUES 
(6815, 4, 6896, 0),
(6899, 1, 6854, 0),
(6899, 2, 6895, 0);

UPDATE `gossip_menu_option` SET `ActionMenuID` = 21097 WHERE `MenuID` = 6815 AND `OptionID` = 1;
UPDATE `gossip_menu_option` SET `ActionMenuID` = 21107 WHERE `MenuID` = 6815 AND `OptionID` = 2;
UPDATE `gossip_menu_option` SET `ActionMenuID` = 21147 WHERE `MenuID` = 6815 AND `OptionID` = 3;
UPDATE `gossip_menu_option` SET `ActionMenuID` = 21086 WHERE `MenuID` = 6899 AND `OptionID` = 0;
UPDATE `gossip_menu_option` SET `ActionMenuID` = 6854  WHERE `MenuID` = 6899 AND `OptionID` = 1;
UPDATE `gossip_menu_option` SET `ActionMenuID` = 21122 WHERE `MenuID` = 6899 AND `OptionID` = 3;
UPDATE `gossip_menu_option` SET `ActionMenuID` = 21147 WHERE `MenuID` = 6899 AND `OptionID` = 4;
