DROP TABLE IF EXISTS `ai_playerbot_db_store`;

CREATE TABLE `ai_playerbot_db_store` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `guid` int(20) NOT NULL,
  `key` varchar(32) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `guid` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;