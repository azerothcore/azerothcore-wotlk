--
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 10996 AND `OptionID` = 6;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 38316;
UPDATE `creature_template` SET `AIName` = '';
