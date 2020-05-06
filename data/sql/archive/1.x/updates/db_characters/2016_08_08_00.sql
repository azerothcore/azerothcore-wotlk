ALTER TABLE characters_db_version CHANGE COLUMN 2016_07_30_00 2016_08_08_00 bit;

CREATE TABLE IF NOT EXISTS  `battleground_deserters` (
 	`guid` INT(10) UNSIGNED NOT NULL COMMENT 'characters.guid',
 	`type` TINYINT(3) UNSIGNED NOT NULL COMMENT 'type of the desertion',
 	`datetime` DATETIME NOT NULL COMMENT 'datetime of the desertion'
 );

CREATE TABLE IF NOT EXISTS `pvpstats_battlegrounds` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `winner_faction` tinyint(4) NOT NULL,
  `bracket_id` tinyint(3) unsigned NOT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8298 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS  `pvpstats_players` (
  `battleground_id` bigint(20) unsigned NOT NULL,
  `character_guid` int(10) unsigned NOT NULL,
  `winner` bit(1) NOT NULL,
  `score_killing_blows` mediumint(8) unsigned NOT NULL,
  `score_deaths` mediumint(8) unsigned NOT NULL,
  `score_honorable_kills` mediumint(8) unsigned NOT NULL,
  `score_bonus_honor` mediumint(8) unsigned NOT NULL,
  `score_damage_done` mediumint(8) unsigned NOT NULL,
  `score_healing_done` mediumint(8) unsigned NOT NULL,
  `attr_1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `attr_2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `attr_3` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `attr_4` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `attr_5` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`battleground_id`,`character_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

