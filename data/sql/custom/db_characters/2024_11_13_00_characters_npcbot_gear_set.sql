--
DROP TABLE IF EXISTS `characters_npcbot_gear_set`;
CREATE TABLE `characters_npcbot_gear_set` (
  `owner` int unsigned NOT NULL DEFAULT '0',
  `set_id` tinyint unsigned NOT NULL DEFAULT '0',
  `set_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`owner`,`set_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bot equipment sets system';
