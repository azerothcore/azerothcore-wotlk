INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1592179496642830400');

CREATE TABLE IF NOT EXISTS `world_config` (
  `Index` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `ConfigName` VARCHAR(255) NOT NULL,
  `Value` VARCHAR(255) NOT NULL,
  `Comment` TEXT NULL DEFAULT NULL,
   PRIMARY KEY (`Index`, `ConfigName`)
) ENGINE=MyISAM DEFAULT CHARSET=UTF8MB3 COMMENT='Holds configs for the World Server';

/*
INDEX:
0 - UNDEFINED INDEX
1 - PERFORMANCE SETTINGS
2 - SERVER LOGGING
3 - SERVER SETTINGS
4 - WARDEN SETTINGS
5 - PLAYER SETTINGS
6 - CREATURE SETTINGS
7 - CHAT SETTINGS
8 - GM SETTINGS
9 - VISIBILITY AND DISTANCES
10 - SERVER RATES
11 - AUTO BROADCAST
12 - BATTLEGROUND SETTINGS
13 - BATTLEFIELD SETTINGS
14 - ARENA SETTINGS
15 - CHARACTER DELETE SETTINGS
16 - ITEM DELETE SETTINGS
17 - CUSTOM SERVER SETTINGS (TODO: Can probably fit in other categories or be re-done)
18 - PACKET SPOOF PROTECTION SETTINGS
19 - DEBUG
*/


REPLACE INTO `world_config` (`Index`, `ConfigName`, `Value`, `Comment`) VALUES
(17, 'ICC.Buff.Horde', 73822, 'Specify ICC buff\r\n
It is necessary to restart the server after changing the values!\r\n
Default: ICC.Buff.Horde = 73822\r\n
Spell IDs for the auras:\r\n
73816 -  5% buff Horde\r\n
73818 - 10% buff Horde\r\n
73819 - 15% buff Horde\r\n
73820 - 20% buff Horde\r\n
73821 - 25% buff Horde\r\n
73822 - 30% buff Horde');
