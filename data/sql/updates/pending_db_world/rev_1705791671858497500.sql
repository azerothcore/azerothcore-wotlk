--
UPDATE `command` SET `help`='Syntax: .server set motd Optional($realmId) $MOTD\r\n\r\nSet server Message of the day for the specified $realmId.\r\nIf $realmId is not provided it will update for the current realm.' WHERE  `name`='server set motd';
