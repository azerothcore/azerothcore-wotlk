INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620594734059183600');

DELETE FROM `gossip_menu` WHERE (`MenuID` = 1013) AND (`TextID` IN (5822));
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(1013, 5822);

DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 4764) AND (`OptionID` IN (0, 1, 2, 3));

INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(1013, 0, 0, 'Kel''Thuzad is my answer.', 8377, 1, 1, 0, 0, 0, 0, '', 0, 0);

INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(1013, 1, 0, 'Gul''dan is my answer.', 8378, 1, 1, 0, 0, 0, 0, '', 0, 0);

INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(1013, 2, 0, 'Ner''zhul is my answer.', 8380, 1, 1, 0, 0, 0, 0, '', 0, 0);
