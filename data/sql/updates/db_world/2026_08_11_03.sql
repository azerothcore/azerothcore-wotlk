-- DB update 2026_08_11_02 -> 2026_08_11_03
DELETE FROM `command` WHERE `name` IN ('account set gmlevel');
INSERT INTO `command` (`name`, `security`, `help`) VALUES ('account set gmlevel',3,'Syntax: .account set gmlevel [$account] #level #realmID\r\n\r\nSet the security level for targeted player (can\'t be used at self) or for an account name ($account) to a level of #level on the realm #realmID.\r\n\r\n#level may range from 0 to 3.\r\n\r\n#realmID may be -1 for all realms.');
