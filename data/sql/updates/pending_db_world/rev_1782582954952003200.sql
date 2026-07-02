-- Update help text for .settings announcer to list all supported types
UPDATE `command` SET `help`='Syntax: .settings announcer <type> <on/off>.\nDisables receiving announcements. Valid announcement types are: \'autobroadcast\', \'arena\', \'bg\', \'pvpstart\' and \'pvpall\'' WHERE `name`='settings announcer';
