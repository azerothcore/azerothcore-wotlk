CREATE TABLE IF NOT EXISTS `account_ip` (
  `account` int(10) unsigned NOT NULL COMMENT 'account.id',
  `ip` varchar(15) NOT NULL,
  `first_time` DATETIME NOT NULL COMMENT 'first time the account has logged with this ip',
  `last_time` DATETIME NOT NULL COMMENT 'last time the account has logged with this ip',
  PRIMARY KEY (`account`, `ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='mod-ip-tracker';
