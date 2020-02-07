INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1581036302051256100');

-- Dumping structure for table characters.premium_character
CREATE TABLE IF NOT EXISTS `premium_character` (
  `character_id` int(10) unsigned NOT NULL,
  `premium_level` int(10) unsigned NOT NULL,
  PRIMARY KEY (`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
