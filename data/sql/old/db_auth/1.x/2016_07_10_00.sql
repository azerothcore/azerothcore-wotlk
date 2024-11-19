ALTER TABLE auth_db_version CHANGE COLUMN 2016_07_09_01 2016_07_10_00 bit;

DROP TABLE IF EXISTS `autobroadcast`;
CREATE TABLE `autobroadcast` (
  `realmid` int(10) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `weight` tinyint(3) DEFAULT 1,
  `text` longtext NOT NULL,
  PRIMARY KEY (`id`, `realmid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
 
ALTER TABLE `autobroadcast`
 CHANGE `realmid` `realmid` INT(11) NOT NULL DEFAULT '-1',
 CHANGE `id` `id` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
 CHANGE `weight` `weight` TINYINT(3) UNSIGNED DEFAULT '1',
ENGINE=INNODB;
