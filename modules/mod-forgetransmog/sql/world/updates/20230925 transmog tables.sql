-- acore_characters.forge_account_transmog definition
DROP TABLE IF EXISTS `acore_characters`.`forge_account_transmog`;
CREATE TABLE `acore_characters`.`forge_account_transmog` (
  `accountid` int unsigned NOT NULL,
  `type` int unsigned NOT NULL,
  `entry` int unsigned NOT NULL,
  PRIMARY KEY (`accountid`,`type`,`entry`),
  KEY `accountid` (`accountid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


-- acore_characters.forge_character_transmogsets definition

DROP TABLE IF EXISTS `acore_characters`.`forge_character_transmogsets`;
CREATE TABLE `acore_characters`.`forge_character_transmogsets`; (
  `guid` int unsigned NOT NULL,
  `setid` tinyint unsigned NOT NULL,
  `setname` varchar(32) NOT NULL DEFAULT 'New Set',
  `head` int unsigned NOT NULL DEFAULT '0',
  `shoulders` int unsigned NOT NULL DEFAULT '0',
  `shirt` int unsigned NOT NULL DEFAULT '0',
  `chest` int unsigned NOT NULL DEFAULT '0',
  `waist` int unsigned NOT NULL DEFAULT '0',
  `legs` int unsigned NOT NULL DEFAULT '0',
  `feet` int unsigned NOT NULL DEFAULT '0',
  `wrists` int unsigned NOT NULL DEFAULT '0',
  `hands` int unsigned NOT NULL DEFAULT '0',
  `back` int unsigned NOT NULL DEFAULT '0',
  `mh` int unsigned NOT NULL DEFAULT '0',
  `oh` int unsigned NOT NULL DEFAULT '0',
  `ranged` int unsigned NOT NULL DEFAULT '0',
  `tabard` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`setid`),
  KEY `Character` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;