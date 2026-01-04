-- DB update 2024_01_20_05 -> 2024_01_20_06
--
UPDATE `command` SET `help`='Syntax: .server set motd Optional($realmId) $MOTD\r\n\r\nSet server Message of the day for the specified $realmId.\r\nIf $realmId is not provided it will update for the current realm.\r\nUse $realmId -1 to set motd for all realms.' WHERE  `name`='server set motd';
