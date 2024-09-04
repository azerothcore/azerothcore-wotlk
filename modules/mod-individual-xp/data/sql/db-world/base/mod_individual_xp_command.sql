DELETE FROM `command` WHERE `name` IN ('xp', 'xp set', 'xp view', 'xp default', 'xp enable', 'xp disable');

INSERT INTO `command` (`name`, `security`, `help`) VALUES 
('xp', 0, 'Syntax: .xp $subcommand\nType .help xp to see a list of subcommands\nor .help xp $subcommand to see info on the subcommand.'),
('xp set', 0, 'Syntax: .xp set $rate\nSet your custom XP rate.'),
('xp view', 0, 'Syntax: .xp view\nView your current XP rate.'),
('xp default', 0, 'Syntax: .xp default\nSet your custom XP rate to the default value'),
('xp enable', 0, 'Syntax: .xp enable\nEnable the custom XP rate.'),
('xp disable', 0, 'Syntax: .xp disable\nDisable the custom XP rate.');
