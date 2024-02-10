DELETE FROM `broadcast_text` WHERE `ID`=78000;
INSERT INTO `broadcast_text` (`ID`, `LanguageID`, `MaleText`, `FemaleText`, `EmoteID1`, `EmoteID2`, `EmoteID3`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `SoundEntriesId`, `EmotesID`, `Flags`, `VerifiedBuild`) VALUES 
(78000, 0, 'Nozdormu is my answer.', 'Nozdormu is my answer.', 0, 0, 0, 0, 0, 0, 0, 0, 1, 18019);
DELETE FROM `gossip_menu_option` WHERE `MenuID`=4763 AND `OptionID`=4;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES 
(4763, 4, 0, 'Nozdormu is my answer.', 78000, 1, 1, 0, 0, 0, 0, '', 0, 0);