-- Remove a duplicate and wrong gossip with anachronos
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 6539 AND `OptionID` IN (0);
