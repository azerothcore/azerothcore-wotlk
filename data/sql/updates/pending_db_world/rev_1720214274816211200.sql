--
UPDATE `conditions` SET `ConditionTypeOrReference` = 8 WHERE `SourceGroup` = 8234 AND `SourceTypeOrReferenceId` = 15 AND `ConditionTypeOrReference` = 9;

DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 8234);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(8234, 0, 0, 'I seem to have misplaced my ring.', 21813, 1, 1, 0, 0, 0, 0, '', 0, 55056),
(8234, 1, 0, 'I seem to have misplaced my ring.', 21813, 1, 1, 0, 0, 0, 0, '', 0, 55056),
(8234, 2, 0, 'I seem to have misplaced my ring.', 21813, 1, 1, 0, 0, 0, 0, '', 0, 55056),
(8234, 3, 0, 'I seem to have misplaced my ring.', 21813, 1, 1, 0, 0, 0, 0, '', 0, 55056);
