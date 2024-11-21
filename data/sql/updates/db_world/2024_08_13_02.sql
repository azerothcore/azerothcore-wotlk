-- DB update 2024_08_13_01 -> 2024_08_13_02
--
DROP TABLE IF EXISTS `module_string`;
CREATE TABLE IF NOT EXISTS `module_string` (
  `module` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'module dir name, eg mod-cfbg',
  `id` int unsigned NOT NULL,
  `string` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`module`, `id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `module_string_locale`;
CREATE TABLE IF NOT EXISTS `module_string_locale` (
  `module` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Corresponds to an existing entry in module_string',
  `id` int unsigned NOT NULL COMMENT 'Corresponds to an existing entry in module_string',
  `locale` ENUM('koKR', 'frFR', 'deDE', 'zhCN', 'zhTW', 'esES', 'esMX', 'ruRU') NOT NULL,
  `string` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`module`, `id`, `locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DELETE FROM `command` WHERE `name` = 'reload module_string';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('reload module_string', 3, 'Syntax: .reload module_string');
