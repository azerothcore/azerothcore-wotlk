-- DB update 2023_02_19_11 -> 2023_02_20_00
--
DELETE FROM `command` WHERE `name` = 'reload motd';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('reload motd', 3, 'Syntax: .reload motd
Reload motd table.');

UPDATE `command` SET `help`='Syntax: .server set motd $realmId $MOTD\r\n\r\nSet server Message of the day for the specified realm.' WHERE  `name`='server set motd';

UPDATE `acore_string` SET `content_default`='Message of the day in realm %i changed to:\r\n%s', `locale_deDE`='Nachricht des Tages in Realm %i wurde geändert zu:\r\n%s', `locale_zhCN`='每日消息更改为 in realm %i:\r\n%s' WHERE `entry`=1101;
