
CREATE TABLE `character_brew_of_the_month` (
  `guid` int(10) unsigned NOT NULL,
  `lastEventId` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
CREATE TABLE `log_encounter` (
  `time` datetime NOT NULL,
  `map` smallint(5) unsigned NOT NULL,
  `difficulty` tinyint(3) unsigned NOT NULL,
  `creditType` tinyint(3) unsigned NOT NULL,
  `creditEntry` int(10) unsigned NOT NULL,
  `playersInfo` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
CREATE TABLE `log_money` (
  `sender_acc` int(11) unsigned NOT NULL,
  `sender_guid` int(11) unsigned NOT NULL,
  `sender_name` char(32) CHARACTER SET utf8 NOT NULL,
  `sender_ip` char(32) CHARACTER SET utf8 NOT NULL,
  `receiver_acc` int(11) unsigned NOT NULL,
  `receiver_name` char(32) CHARACTER SET utf8 NOT NULL,
  `money` bigint(20) unsigned NOT NULL,
  `topic` char(255) CHARACTER SET utf8 NOT NULL,
  `date` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
CREATE TABLE `gm_subsurveys` (
  `surveyId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `subsurveyId` int(10) unsigned NOT NULL DEFAULT '0',
  `rank` int(10) unsigned NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  PRIMARY KEY (`surveyId`,`subsurveyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System';
CREATE TABLE `gm_surveys` (
  `surveyId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `guid` int(10) unsigned NOT NULL DEFAULT '0',
  `mainSurvey` int(10) unsigned NOT NULL DEFAULT '0',
  `overallComment` longtext NOT NULL,
  `createTime` int(10) unsigned NOT NULL DEFAULT '0',
  `maxMMR` smallint(5) NOT NULL,
  PRIMARY KEY (`surveyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System';
CREATE TABLE `gm_tickets` (
  `ticketId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `guid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier of ticket creator',
  `name` varchar(12) NOT NULL COMMENT 'Name of ticket creator',
  `message` text NOT NULL,
  `createTime` int(10) unsigned NOT NULL DEFAULT '0',
  `mapId` smallint(5) unsigned NOT NULL DEFAULT '0',
  `posX` float NOT NULL DEFAULT '0',
  `posY` float NOT NULL DEFAULT '0',
  `posZ` float NOT NULL DEFAULT '0',
  `lastModifiedTime` int(10) unsigned NOT NULL DEFAULT '0',
  `closedBy` int(10) NOT NULL DEFAULT '0',
  `assignedTo` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'GUID of admin to whom ticket is assigned',
  `comment` text NOT NULL,
  `response` text NOT NULL,
  `completed` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `escalated` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `viewed` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `haveTicket` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ticketId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System';
CREATE TABLE `item_loot_storage` (
  `containerGUID` int(10) unsigned NOT NULL,
  `itemid` int(10) unsigned NOT NULL,
  `count` int(10) unsigned NOT NULL,
  `randomPropertyId` int(10) NOT NULL,
  `randomSuffix` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `character_entry_point` (
  `guid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `joinX` float NOT NULL DEFAULT '0',
  `joinY` float NOT NULL DEFAULT '0',
  `joinZ` float NOT NULL DEFAULT '0',
  `joinO` float NOT NULL DEFAULT '0',
  `joinMapId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Map Identifier',
  `taxiPath` text,
  `mountSpell` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System';
CREATE TABLE `channels_bans` (
  `channelId` int(10) unsigned NOT NULL,
  `playerGUID` int(10) unsigned NOT NULL,
  `banTime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`channelId`,`playerGUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `channels_rights`
--

DROP TABLE IF EXISTS `channels_rights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `channels_rights` (
  `name` varchar(128) NOT NULL,
  `flags` int(10) unsigned NOT NULL,
  `speakdelay` int(10) unsigned NOT NULL,
  `joinmessage` varchar(255) NOT NULL DEFAULT '',
  `delaymessage` varchar(255) NOT NULL DEFAULT '',
  `moderators` text,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `channels_rights`
--

LOCK TABLES `channels_rights` WRITE;
/*!40000 ALTER TABLE `channels_rights` DISABLE KEYS */;
/*!40000 ALTER TABLE `channels_rights` ENABLE KEYS */;
UNLOCK TABLES;


ALTER TABLE `character_spell_cooldown` ADD COLUMN `needSend` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1' AFTER `categoryEnd`;
ALTER TABLE `auctionhouse` CHANGE COLUMN `houseid` `auctioneerguid` INT(10) UNSIGNED NOT NULL DEFAULT '0' ;
ALTER TABLE `channels` 
ADD COLUMN `channelId` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT FIRST,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`channelId`);

TRUNCATE TABLE `character_talent`;
ALTER TABLE `character_talent` 
CHANGE COLUMN `talentGroup` `specMask` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' ,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`guid`, `spell`);
ALTER TABLE `characters` 
ADD COLUMN `playerBytes` INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `money`,
ADD COLUMN `playerBytes2` INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `playerBytes`;
UPDATE `characters` SET 
 playerBytes = (skin) | (face << 8) | (hairStyle << 16) | (hairColor << 24),
 playerBytes2 = (facialStyle) | (bankSlots << 16) | (restState << 24)
WHERE guid > 0;
ALTER TABLE `characters` DROP COLUMN `skin`;
ALTER TABLE `characters` DROP COLUMN `face`;
ALTER TABLE `characters` DROP COLUMN `hairStyle`;
ALTER TABLE `characters` DROP COLUMN `hairColor`;
ALTER TABLE `characters` DROP COLUMN `facialStyle`;
ALTER TABLE `characters` DROP COLUMN `bankSlots`;
ALTER TABLE `characters` 
CHANGE COLUMN `talentGroupsCount` `speccount` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1' ,
CHANGE COLUMN `activeTalentGroup` `activespec` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' ,
DROP COLUMN `restState`;

ALTER TABLE `character_glyphs` 
CHANGE COLUMN `talentGroup` `spec` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0';


ALTER TABLE `character_instance` 
CHANGE COLUMN `extendState` `extended` TINYINT(2) UNSIGNED NOT NULL DEFAULT '0' ;

ALTER TABLE `character_arena_stats` 
ADD COLUMN `maxMMR` smallint(5) NOT NULL AFTER `matchMakerRating`;

TRUNCATE TABLE `corpse`;
ALTER TABLE `corpse` 
ADD COLUMN `corpseGuid` INT(10) UNSIGNED NOT NULL DEFAULT '0' FIRST,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`corpseGuid`, `guid`);

ALTER TABLE `character_aura` 
CHANGE COLUMN `casterGuid` `caster_guid` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Full Global Unique Identifier' ,
CHANGE COLUMN `itemGuid` `item_guid` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0' ,
CHANGE COLUMN `effectMask` `effect_mask` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' ,
CHANGE COLUMN `recalculateMask` `recalculate_mask` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' ;


ALTER TABLE `pet_aura` 
CHANGE COLUMN `casterGuid` `caster_guid` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Full Global Unique Identifier' ,
CHANGE COLUMN `effectMask` `effect_mask` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' ,
CHANGE COLUMN `recalculateMask` `recalculate_mask` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' ;

-- ALTER TABLE `character_spell` 
-- DROP COLUMN `disabled`,
-- CHANGE COLUMN `active` `specMask` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' ;

