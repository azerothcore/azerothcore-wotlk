INSERT INTO `version_db_auth` (`sql_rev`) VALUES ('1581036016792184400');

-- Dumping structure for table auth.premium_account
CREATE TABLE IF NOT EXISTS `premium_account` (
  `account_id` int(10) unsigned NOT NULL,
  `premium_level` int(10) unsigned NOT NULL,
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
