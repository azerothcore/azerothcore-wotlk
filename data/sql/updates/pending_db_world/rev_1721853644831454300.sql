--
DROP TABLE IF EXISTS `module_string`;
CREATE TABLE IF NOT EXISTS `module_string` (
  `module` varchar(255) NOT NULL COMMENT 'module dir name, eg mod-cfbg',
  `id` int unsigned NOT NULL,
  `content_default` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `locale_koKR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `locale_frFR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `locale_deDE` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `locale_zhCN` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `locale_zhTW` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `locale_esES` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `locale_esMX` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `locale_ruRU` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`module`, `id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DELETE FROM `command` WHERE `name` = 'reload module_string';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('reload module_string', 3, 'Syntax: .reload module_string');
