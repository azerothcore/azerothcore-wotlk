--
DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 2849);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(2849, 0, 0, 'The auction house', 0, 1, 1, 2827, 318, 0, 0, '', 0, 0),
(2849, 1, 0, 'The bank', 4888, 1, 1, 2822, 319, 0, 0, '', 0, 0),
(2849, 2, 0, 'Barber', 45376, 1, 1, 10020, 320, 0, 0, '', 0, 0),
(2849, 3, 0, 'The bat handler', 6790, 1, 1, 2823, 321, 0, 0, '', 0, 0),
(2849, 4, 0, 'The battlemaster', 0, 1, 1, 8225, 322, 0, 0, '', 0, 0),
(2849, 5, 0, 'The guild master', 0, 1, 1, 2824, 323, 0, 0, '', 0, 0),
(2849, 6, 0, 'The inn', 4893, 1, 1, 2825, 324, 0, 0, '', 0, 0),
(2849, 7, 0, 'Locksmith', 33141, 1, 1, 10261, 325, 0, 0, '', 0, 0),
(2849, 8, 0, 'The mailbox', 0, 1, 1, 2826, 326, 0, 0, '', 0, 0),
(2849, 9, 0, 'The stable master', 8521, 1, 1, 4906, 327, 0, 0, '', 0, 0),
(2849, 10, 0, 'The weapon master', 0, 1, 1, 3726, 328, 0, 0, '', 0, 0),
(2849, 11, 0, 'The zeppelin master', 0, 1, 1, 2828, 329, 0, 0, '', 0, 0),
(2849, 12, 0, 'A class trainer', 6792, 1, 1, 2848, 0, 0, 0, '', 0, 0),
(2849, 13, 0, 'A profession trainer', 6793, 1, 1, 2847, 0, 0, 0, '', 0, 0);

-- Trainer Action Menus
DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (2847, 2848);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`) VALUES
(2847, 0, 0, 'Alchemy', 0, 1, 1, 2834, 336),
(2847, 1, 0, 'Blacksmithing', 0, 1, 1, 2835, 337),
(2847, 2, 0, 'Cooking', 0, 1, 1, 2836, 338),
(2847, 3, 0, 'Enchanting', 0, 1, 1, 2837, 339),
(2847, 4, 0, 'Engineering', 0, 1, 1, 2838, 340),
(2847, 5, 0, 'First Aid', 0, 1, 1, 2839, 341),
(2847, 6, 0, 'Fishing', 0, 1, 1, 2840, 342),
(2847, 7, 0, 'Herbalism', 0, 1, 1, 2841, 343),
(2847, 8, 0, 'Inscription', 0, 1, 1, 10019, 344),
(2847, 9, 0, 'Leatherworking', 0, 1, 1, 2842, 345),
(2847, 10, 0, 'Mining', 0, 1, 1, 2843, 347),
(2847, 11, 0, 'Skinning', 0, 1, 1, 2844, 346),
(2847, 12, 0, 'Tailoring', 0, 1, 1, 2845, 348),
(2848, 0, 0, 'Mage', 0, 1, 1, 2821, 331),
(2848, 1, 0, 'Paladin', 0, 1, 1, 8165, 330),
(2848, 2, 0, 'Priest', 0, 1, 1, 2829, 332),
(2848, 3, 0, 'Rogue', 0, 1, 1, 2830, 333),
(2848, 4, 0, 'Warlock', 0, 1, 1, 2832, 334),
(2848, 5, 0, 'Warrior', 0, 1, 1, 2833, 335);
