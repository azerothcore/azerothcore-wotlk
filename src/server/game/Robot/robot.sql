DROP TABLE IF EXISTS `robot`;
CREATE TABLE `robot` (
  `entry` int(11) NOT NULL AUTO_INCREMENT,
  `robot_id` int(11) NOT NULL DEFAULT '0',
  `account_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `character_id` int(11) NOT NULL DEFAULT '0',
  `target_level` int(11) NOT NULL DEFAULT '0',
  `robot_type` int(11) NOT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB AUTO_INCREMENT=851 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
