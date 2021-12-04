INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638641366613580300');

DELETE FROM `command` WHERE `name` IN ('settings', 'settings announcer');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('settings', 1, 'Syntax: .settings $subcommand\nType .setting to see the list of all available commands.'),
('settings announcer', 1, 'Syntax: .settings announcer <type> <on/off>.\nDisables receiving announcements. Valid announcement types are: \'autobroadcast\', \'arena\' and \'battleground\'');

DELETE FROM `acore_string` WHERE `entry` IN (5070, 5071, 5072);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(5070, 'You must be at least level %u to disable autobroadcast messages.'),
(5071, 'You are now receiving global messages from %s.'),
(5072, 'You will no longer receive global messages from %s');
