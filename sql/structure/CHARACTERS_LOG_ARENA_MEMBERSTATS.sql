CREATE TABLE `log_arena_memberstats` (
  `fight_id` int(10) unsigned NOT NULL,
  `member_id` tinyint(3) unsigned NOT NULL,
  `name` char(20) NOT NULL,
  `guid` int(10) unsigned NOT NULL,
  `team` int(10) unsigned NOT NULL,
  `account` int(10) unsigned NOT NULL,
  `ip` char(15) NOT NULL,
  `damage` int(10) unsigned NOT NULL,
  `heal` int(10) unsigned NOT NULL,
  `kblows` int(10) unsigned NOT NULL,
  PRIMARY KEY (`fight_id`,`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

