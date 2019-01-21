INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1547598400341720700');

DELETE FROM `command` WHERE `name` IN ('spy follow', 'spy unfollow', 'spy groupfollow', 'spy groupunfollow', 'spy clear', 'spy status');
INSERT INTO `command` (`name`,`security`,`help`) VALUES
('spy follow',          2, 'Syntax: .spy follow [$name]\nStarts reading all the private conversations of that player.'),
('spy unfollow',        2, 'Syntax: .spy unfollow [$name]\nStops reading private messages from that player.'),
('spy groupfollow',     3, 'Syntax: .spy groupfollow [$name]\nStarts reading all the private conversations of that player and his current party.'),
('spy groupunfollow',   3, 'Syntax: .spy groupunfollow [$name]\nStops reading private messages from that player\'s party.'),
('spy clear',           2, 'Syntax: .spy clear\nClears your current spying list, removing every player from it.'),
('spy status',          2, 'Syntax: .spy status\nShows your current spying list.');
