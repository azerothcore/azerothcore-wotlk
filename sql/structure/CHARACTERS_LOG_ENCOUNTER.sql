CREATE TABLE `log_encounter` (
  `time` datetime NOT NULL,
  `map` smallint(5) unsigned NOT NULL,
  `difficulty` tinyint(3) unsigned NOT NULL,
  `creditType` tinyint(3) unsigned NOT NULL,
  `creditEntry` int(10) unsigned NOT NULL,
  `playersInfo` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
