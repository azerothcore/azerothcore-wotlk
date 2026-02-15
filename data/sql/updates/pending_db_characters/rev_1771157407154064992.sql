-- Create table for LFG activity tracking
-- Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/5477

DROP TABLE IF EXISTS `lfg_activity`;
CREATE TABLE `lfg_activity` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier',
  `playerGuid` int unsigned NOT NULL COMMENT 'Player GUID',
  `eventType` tinyint unsigned NOT NULL COMMENT 'Event type: 1=joined, 2=refused, 3=left, 4=kicked, 5=disconnected',
  `dungeonId` int unsigned NOT NULL COMMENT 'Dungeon/Raid ID',
  `groupGuid` int unsigned DEFAULT NULL COMMENT 'Group GUID if applicable',
  `timestamp` int unsigned NOT NULL COMMENT 'Unix timestamp of the event',
  PRIMARY KEY (`id`),
  KEY `idx_player` (`playerGuid`),
  KEY `idx_timestamp` (`timestamp`),
  KEY `idx_dungeon` (`dungeonId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='LFG Activity Tracking';
