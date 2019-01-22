INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1548117070754986000');

DELETE FROM `command` WHERE `name` IN ('spy follow', 'spy unfollow', 'spy groupfollow', 'spy groupunfollow', 'spy clear', 'spy status');
INSERT INTO `command` (`name`,`security`,`help`) VALUES
('spy follow',          2, 'Syntax: .spy follow $name\nStart reading all the private conversations from that player.'),
('spy unfollow',        2, 'Syntax: .spy unfollow $name\nStop reading private messages from that player.'),
('spy groupfollow',     3, 'Syntax: .spy groupfollow $name\nStart reading all the private conversations from that player and from his current party.'),
('spy groupunfollow',   3, 'Syntax: .spy groupunfollow $name\nStop reading private messages from that player\'s party.'),
('spy clear',           2, 'Syntax: .spy clear\nClear your current spying list, removing every player from it.'),
('spy status',          2, 'Syntax: .spy status\nShow your current spying list.');
