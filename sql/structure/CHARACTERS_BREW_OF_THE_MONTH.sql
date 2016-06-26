-- ----------------------------
-- Table structure for character_brew_of_the_month
-- ----------------------------
DROP TABLE IF EXISTS `character_brew_of_the_month`;
CREATE TABLE `character_brew_of_the_month` (
  `guid` int(10) unsigned NOT NULL,
  `lastEventId` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
