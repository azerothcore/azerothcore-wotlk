INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1638643807174948000');

DROP TABLE IF EXISTS `character_settings`;
CREATE TABLE IF NOT EXISTS `character_settings` (
  `guid` INT UNSIGNED NOT NULL,
  `source` INT UNSIGNED NOT NULL,
  `data` TEXT NULL,
  PRIMARY KEY (`guid`, `source`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8mb4 COMMENT='Player Settings';
