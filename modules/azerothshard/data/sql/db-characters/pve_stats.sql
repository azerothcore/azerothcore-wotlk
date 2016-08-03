CREATE TABLE IF NOT EXISTS azth_achievement_stats (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `playerGuid` int(10) unsigned NOT NULL DEFAULT '0',
  `achievement` int(10) unsigned NOT NULL DEFAULT '0',
  `type` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '0 -> achievement, 1 -> criteria',
  `level` int(10) unsigned NOT NULL DEFAULT '0',
  `levelParty` int(10) unsigned DEFAULT '0',
  `date` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
 
 
