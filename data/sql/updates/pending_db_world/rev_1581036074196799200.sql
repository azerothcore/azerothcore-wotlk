INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1581036074196799200');
DELETE FROM `command` WHERE `name` LIKE 'premium%';
INSERT INTO `command` (`name`, `security`, `help`) VALUES 
('premium', 1, 'Syntax: .premium $subcommand\r\nType .premium to see the list of possible subcommands or .help premium $subcommand to see info on subcommands'),
('premium account', 1, 'Syntax: .premium account  $subcommand\r\nType .premium account to see the list of possible subcommands or .help premium account  $subcommand to see info on subcommands'),
('premium account create', 1, 'Syntax: .premium account create #premium level \r\nWill make the selected character''s account premium with specified level'),
('premium account delete', 1, 'Syntax: .premium account delete\r\nWill remove the selected character''s account from the premium account table'),
('premium account info', 1, 'Syntax: .premium account info\r\nDisplay the premium level for the selected target''s account'),
('premium character', 1, 'Syntax: .premium character $subcommand\r\nType .premium character to see the list of possible subcommands or .help premium character $subcommand to see info on subcommands'),
('premium character create', 1, 'Syntax: .premium character create #premium value\r\nWill add the selected character to the premium character table with specified premium value'),
('premium character delete', 1, 'Syntax: .premium character delete\r\nWill remove the selected character from the premium character table'),
('premium character info', 1, 'Syntax: .premium character info\r\nDisplay the premium level for the selected target''s character');
