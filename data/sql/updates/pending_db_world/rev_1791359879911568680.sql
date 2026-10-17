--
CREATE TABLE IF NOT EXISTS `acore_string_locale` (
  `entry` int unsigned NOT NULL COMMENT 'acore_string.entry',
  `locale` varchar(4) NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`entry`, `locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='acore_string texts by locale name';
