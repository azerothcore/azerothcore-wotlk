INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1592179496642830400');

CREATE TABLE IF NOT EXISTS `world_config` (
  `name` VARCHAR(255) NOT NULL,
  `value` INT UNSIGNED NOT NULL,
  `comment` TEXT,
   PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=UTF8MB3 COMMENT='Holds configs for the World Server';

REPLACE INTO `world_config` (`name`, `value`, `comment`) VALUES
('ICC.Buff.Horde', 73822, 'Specify ICC buff\r\n
It is necessary to restart the server after changing the values!\r\n
Default: ICC.Buff.Horde = 73822\r\n
Spell IDs for the auras:\r\n
73816 -  5% buff Horde\r\n
73818 - 10% buff Horde\r\n
73819 - 15% buff Horde\r\n
73820 - 20% buff Horde\r\n
73821 - 25% buff Horde\r\n
73822 - 30% buff Horde');
