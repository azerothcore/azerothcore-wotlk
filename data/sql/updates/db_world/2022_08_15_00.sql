-- DB update 2022_08_14_05 -> 2022_08_15_00
-- Remove a duplicate and wrong gossip with anachronos
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 6539 AND `OptionID` IN (0);
