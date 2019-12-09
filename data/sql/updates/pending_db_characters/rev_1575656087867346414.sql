INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1575656087867346414');

CREATE TABLE IF NOT EXISTS `recovery_item` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Guid` int(11) unsigned NOT NULL DEFAULT 0,
  `ItemEntry` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `Count` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`),
  KEY `idx_guid` (`Guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
