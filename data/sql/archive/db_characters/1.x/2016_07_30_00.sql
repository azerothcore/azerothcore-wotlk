ALTER TABLE characters_db_version CHANGE COLUMN 2016_07_10_00 2016_07_30_00 bit;

CREATE TABLE IF NOT EXISTS `gm_ticket` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0 open, 1 closed, 2 character deleted',
  `playerGuid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier of ticket creator',
  `name` varchar(12) NOT NULL COMMENT 'Name of ticket creator',
  `description` text NOT NULL,
  `createTime` int(10) unsigned NOT NULL DEFAULT '0',
  `mapId` smallint(5) unsigned NOT NULL DEFAULT '0',
  `posX` float NOT NULL DEFAULT '0',
  `posY` float NOT NULL DEFAULT '0',
  `posZ` float NOT NULL DEFAULT '0',
  `lastModifiedTime` int(10) unsigned NOT NULL DEFAULT '0',
  `closedBy` int(10) unsigned NOT NULL DEFAULT '0',
  `assignedTo` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'GUID of admin to whom ticket is assigned',
  `comment` text NOT NULL,
  `response` text NOT NULL,
  `completed` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `escalated` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `viewed` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `needMoreHelp` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `resolvedBy` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'GUID of GM who resolved the ticket',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10572 DEFAULT CHARSET=utf8 COMMENT='Player System';
