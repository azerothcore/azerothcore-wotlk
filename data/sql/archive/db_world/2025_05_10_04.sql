-- DB update 2025_05_10_03 -> 2025_05_10_04
UPDATE `command` SET `help` = 'Syntax: .reload config\r\n\r\nReload config settings (by default stored in worldserver.conf). Not all settings can be change at reload: some new setting values will be ignored until restart, some values will applied with delay or only to new objects/maps, some values will explicitly rejected to change at reload.' WHERE `name` = 'reload config';
UPDATE `command` SET `help` = 'Syntax: .server exit\r\n\r\nTerminate AzerothCore NOW. Exit code 0.' WHERE `name` = 'server exit';
