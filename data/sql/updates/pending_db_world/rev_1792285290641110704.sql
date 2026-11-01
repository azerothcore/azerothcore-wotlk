-- Help text for the voice chat commands, their RBAC permissions are added to the auth database.
DELETE FROM `command` WHERE `name` IN ('voicechat', 'voicechat disconnect', 'voicechat disable', 'voicechat enable', 'voicechat stats');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('voicechat', 3, 'Syntax: .voicechat $subcommand\nType .help voicechat $subcommand to see info on a subcommand.'),
('voicechat disconnect', 3, 'Syntax: .voicechat disconnect\nDrops the voiceserver connection to force a reconnect.'),
('voicechat disable', 3, 'Syntax: .voicechat disable\nDisables voice chat and disconnects from the voiceserver.'),
('voicechat enable', 3, 'Syntax: .voicechat enable\nEnables voice chat and connects to the voiceserver.'),
('voicechat stats', 3, 'Syntax: .voicechat stats\nShows voice channel, user and microphone counts.');
