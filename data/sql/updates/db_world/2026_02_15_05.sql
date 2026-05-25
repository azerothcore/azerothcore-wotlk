-- DB update 2026_02_15_04 -> 2026_02_15_05
--
UPDATE `gossip_menu_option` SET `BoxCoded` = 1 WHERE `MenuID` = 6565 AND `OptionID` IN (0, 1, 2);
UPDATE `gossip_menu_option` SET `BoxCoded` = 1 WHERE `MenuID` = 7034 AND `OptionID` = 0;
