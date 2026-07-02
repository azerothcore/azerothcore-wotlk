DELETE FROM `acore_string` WHERE `entry` IN (35455, 35456, 35457, 35458);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(35455, 'Syntax: .titles add #title [$playername]\nAdd title #title (id or shift-link) to known titles list for selected player.'),
(35456, 'Syntax: .titles current #title [$playername]\nSet title #title (id or shift-link) as current selected title for selected player. If title is not in known title list for player then it will be added to list.'),
(35457, 'Syntax: .titles remove #title [$playername]\nRemove title #title (id or shift-link) from known titles list for selected player.'),
(35458, 'Syntax: .titles set mask #mask [$playername]\nAllows user to use all titles from #mask.\n #mask=0 disables the title-choose-field.');
