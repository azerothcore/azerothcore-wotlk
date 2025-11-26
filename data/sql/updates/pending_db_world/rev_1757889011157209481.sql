--
DROP TABLE IF EXISTS `npcsounds_dbc`;

CREATE TABLE `npcsounds_dbc` ( `Id` INT(10) NOT NULL, `hello` INT(10) DEFAULT 0, `goodbye` INT(10) DEFAULT 0, `pissed` INT(10) DEFAULT 0, `ack` INT(10) DEFAULT 0, PRIMARY KEY (`Id`) );

DROP TABLE IF EXISTS `creature_template_outfits`;

CREATE TABLE `creature_template_outfits` (
  `entry` int unsigned NOT NULL,
  `npcsoundsid` int unsigned NOT NULL DEFAULT '0' COMMENT 'entry from NPCSounds.dbc/db2',
  `race` tinyint unsigned NOT NULL DEFAULT '1',
  `class` tinyint unsigned NOT NULL DEFAULT '1',
  `gender` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '0 for male, 1 for female',
  `skin` tinyint unsigned NOT NULL DEFAULT '0',
  `face` tinyint unsigned NOT NULL DEFAULT '0',
  `hair` tinyint unsigned NOT NULL DEFAULT '0',
  `haircolor` tinyint unsigned NOT NULL DEFAULT '0',
  `facialhair` tinyint unsigned NOT NULL DEFAULT '0',
  `head` int NOT NULL DEFAULT '0',
  `shoulders` int NOT NULL DEFAULT '0',
  `body` int NOT NULL DEFAULT '0',
  `chest` int NOT NULL DEFAULT '0',
  `waist` int NOT NULL DEFAULT '0',
  `legs` int NOT NULL DEFAULT '0',
  `feet` int NOT NULL DEFAULT '0',
  `wrists` int NOT NULL DEFAULT '0',
  `hands` int NOT NULL DEFAULT '0',
  `back` int NOT NULL DEFAULT '0',
  `tabard` int NOT NULL DEFAULT '0',
  `guildid` int unsigned NOT NULL DEFAULT '0',
  `description` text,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Use positive values for item entries and negative to use item displayid for head, shoulders etc.';
