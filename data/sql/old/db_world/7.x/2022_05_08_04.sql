-- DB update 2022_05_08_03 -> 2022_05_08_04
--
DELETE FROM `gossip_menu` WHERE `MenuID` IN (7106,7107);
INSERT INTO `gossip_menu` VALUES (7106, 8363), (7107, 8364);

UPDATE `gossip_menu_option` SET `ActionMenuID`=7099 WHERE  `MenuID`=7107 AND `OptionID`=0;
