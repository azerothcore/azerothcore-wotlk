CREATE TABLE `log_arena_fights` (
  `fight_id` int(10) unsigned NOT NULL,
  `time` datetime NOT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `duration` int(10) unsigned NOT NULL,
  `winner` int(10) unsigned NOT NULL,
  `loser` int(10) unsigned NOT NULL,
  `winner_tr` smallint(5) unsigned NOT NULL,
  `winner_mmr` smallint(5) unsigned NOT NULL,
  `winner_tr_change` smallint(6) NOT NULL,
  `loser_tr` smallint(5) unsigned NOT NULL,
  `loser_mmr` smallint(5) unsigned NOT NULL,
  `loser_tr_change` smallint(6) NOT NULL,
  `currOnline` int(10) unsigned NOT NULL,
  PRIMARY KEY (`fight_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

