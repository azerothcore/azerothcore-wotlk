-- DB update 2026_02_04_03 -> 2026_02_06_00
--
UPDATE `creature_template` SET `gossip_menu_id` = 8760 WHERE (`entry` = 18752);
UPDATE `creature_template` SET `gossip_menu_id` = 8760 WHERE (`entry` = 18753);
UPDATE `creature_template` SET `gossip_menu_id` = 7816 WHERE (`entry` = 18771);
UPDATE `creature_template` SET `gossip_menu_id` = 10365 WHERE (`entry` = 33676);
UPDATE `creature_template` SET `gossip_menu_id` = 9879 WHERE (`entry` = 33679);
UPDATE `creature_template` SET `gossip_menu_id` = 8646 WHERE (`entry` = 33680);
UPDATE `creature_template` SET `gossip_menu_id` = 10351 WHERE (`entry` = 33682);

DELETE FROM `gossip_menu_option` WHERE `MenuID` = 8760;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(8760, 0, 3, 'Train me.', 3266, 5, 16, 0, 0, 0, 0, '', 0, 0),
(8760, 1, 1, 'Let me browse your goods.', 8097, 3, 128, 0, 0, 0, 0, '', 0, 0);
