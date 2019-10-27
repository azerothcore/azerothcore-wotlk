INSERT INTO `version_db_auth` (`sql_rev`) VALUES ('1572194902854971987');

CREATE TABLE IF NOT EXISTS `remote` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `guid` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `profession` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_guid` (`guid`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
