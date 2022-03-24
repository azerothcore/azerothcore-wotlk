INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1648134606612519725');

-- watcher_of_norgannon pages
REPLACE INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
('1062', '1676'),
('1063', '1675'),
('1064', '1677'),
('1065', '1678');

-- watcher_of_norgannon dialogues
REPLACE INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`)
VALUES 
('1061', '0', '0', 'What function do you serve?', '4054', '1', '3', '1062', '0', '0', '0', null, '0', '0'),
('1062', '0', '0', 'What are the Plates of Uldum?', '4056', '1', '3', '1063', '0', '0', '0', null, '0', '0'),
('1063', '0', '0', 'Where are the Plates of Uldum?', '4057', '1', '3', '1064', '0', '0', '0', null, '0', '0'),
('1064', '0', '0', 'Excuse me? We\'ve been \"rescheduled for visitation\"? What does that mean?!', '4058', '1', '3', '1065', '0', '0', '0', null, '0', '0'),
('1065', '0', '0', 'So... what\'s inside Uldum?', '4059', '1', '3', '1066', '0', '0', '0', null, '0', '0'),
('1066', '0', '0', 'I will return when I have the Plates of Uldum.', '4060', '1', '3', '0', '0', '0', '0', null, '0', '0');
