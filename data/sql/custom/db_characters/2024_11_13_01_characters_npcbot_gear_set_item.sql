--
DROP TABLE IF EXISTS `characters_npcbot_gear_set_item`;
CREATE TABLE `characters_npcbot_gear_set_item` (
  `owner` int unsigned NOT NULL DEFAULT '0',
  `set_id` tinyint unsigned NOT NULL DEFAULT '0',
  `slot` tinyint unsigned NOT NULL DEFAULT '0',
  `item_id` mediumint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`owner`,`set_id`,`slot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bot equipment sets system';
