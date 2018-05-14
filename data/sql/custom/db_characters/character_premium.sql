-- ----------------------------
-- Table structure for premium
-- ----------------------------
DROP TABLE IF EXISTS `premium`;
CREATE TABLE `premium` (
  `AccountId` int(11) unsigned NOT NULL,
  `active` int(11) unsigned NOT NULL default '1'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
