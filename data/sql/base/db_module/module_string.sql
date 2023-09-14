DROP TABLE IF EXISTS `module_string`;
CREATE TABLE IF NOT EXISTS `module_string` (
  `module` varchar(12) NOT NULL DEFAULT NULL COMMENT 'Unique module identifier' COLLATE utf8mb4_unicode_ci,
  `entry` int unsigned NOT NULL DEFAULT '0',
  `content_default` text NOT NULL DEFAULT NULL COLLATE utf8mb4_unicode_ci NOT NULL,
  `locale_koKR` text DEFAULT NULL COLLATE utf8mb4_unicode_ci,
  `locale_frFR` text DEFAULT NULL COLLATE utf8mb4_unicode_ci,
  `locale_deDE` text DEFAULT NULL COLLATE utf8mb4_unicode_ci,
  `locale_zhCN` text DEFAULT NULL COLLATE utf8mb4_unicode_ci,
  `locale_zhTW` text DEFAULT NULL COLLATE utf8mb4_unicode_ci,
  `locale_esES` text DEFAULT NULL COLLATE utf8mb4_unicode_ci,
  `locale_esMX` text DEFAULT NULL COLLATE utf8mb4_unicode_ci,
  `locale_ruRU` text DEFAULT NULL COLLATE utf8mb4_unicode_ci,
  UNIQUE INDEX `module` (`module`, `entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
