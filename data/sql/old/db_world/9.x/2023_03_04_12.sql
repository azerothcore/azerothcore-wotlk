-- DB update 2023_03_04_11 -> 2023_03_04_12
-- Sayge - fix wrong gossip_option (was npc_text)
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 6210 AND `OptionID` = 0;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(6210, 0, 0, 'I would show my liege the beast\'s ear and claim the beast\'s death as my own, taking the reward for my own use.  It is wrong to claim a deed as your own that someone else in fact did.', 10087, 1, 1, 6211, 0, 0, 0, '', 0, 0);
