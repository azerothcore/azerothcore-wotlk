DELETE FROM `acore_string` WHERE `entry` IN (711, 712, 713, 717, 718, 719, 726, 773, 774, 775, 776, 777, 778, 20078);

DELETE FROM `command` WHERE `name` IN ('settings announcer', 'settings announcer autobroadcast');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('settings announcer',               1, 'Syntax: .settings announcer $subcommand\nType .settings announcer to see the list of all available announcement types.'),
('settings announcer autobroadcast', 1, 'Syntax: .settings announcer autobroadcast <on/off>.\nEnables or disables receiving autobroadcast announcements.');
