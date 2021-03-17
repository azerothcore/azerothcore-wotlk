INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1615551654603543000');

-- Dumping structure for table acore_characters.character_fishingsteps
DROP TABLE IF EXISTS `character_fishingsteps`;
CREATE TABLE IF NOT EXISTS `character_fishingsteps` (
  `guid` int unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `fishingSteps` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
