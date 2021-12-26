INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1640532476858588300');

DROP TABLE IF EXISTS `character_settings`;
CREATE TABLE `character_settings` (
  `guid` INT UNSIGNED NOT NULL,
  `source` VARCHAR(40) NOT NULL,
  `data` TEXT NULL,
  PRIMARY KEY (`guid`, `source`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8mb4 COMMENT='Player Settings';
