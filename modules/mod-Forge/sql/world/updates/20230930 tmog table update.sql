DROP TABLE IF EXISTS `acore_characters`.`forge_character_transmogsets`;

CREATE TABLE `acore_characters`.`forge_character_transmogsets` (
  `guid` int unsigned NOT NULL,
  `active` tinyint unsigned not null default 0,
  `setid` tinyint unsigned NOT NULL,
  `setname` varchar(32) not null default 'New Set',
  `head` int unsigned not null default 0,
  `shoulders` int unsigned not null default 0,
  `shirt` int unsigned not null default 0,
  `chest` int unsigned not null default 0,
  `waist` int unsigned not null default 0,
  `legs` int unsigned not null default 0,
  `feet` int unsigned not null default 0,
  `wrists` int unsigned not null default 0,
  `hands` int unsigned not null default 0,
  `back` int unsigned not null default 0,
  `mh` int unsigned not null default 0,
  `oh` int unsigned not null default 0,
  `ranged` int unsigned not null default 0,
  `tabard` int unsigned not null default 0,
  PRIMARY KEY (`guid`,`setid`),
  KEY `Character` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;