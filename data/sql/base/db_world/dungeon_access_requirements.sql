-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               10.6.4-MariaDB - mariadb.org binary distribution
-- Операционная система:         Win64
-- HeidiSQL Версия:              11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Дамп структуры для таблица _acore_world.dungeon_access_requirements
DROP TABLE IF EXISTS `dungeon_access_requirements`;
CREATE TABLE IF NOT EXISTS `dungeon_access_requirements` (
  `dungeon_access_id` TINYINT unsigned NOT NULL COMMENT 'ID from dungeon_access_template',
  `requirement_type` TINYINT unsigned NOT NULL COMMENT '0 = achiev, 1 = quest, 2 = item',
  `requirement_id` mediumint(8) unsigned NOT NULL COMMENT 'Achiev/quest/item ID',
  `requirement_note` varchar(255) DEFAULT NULL COMMENT 'Optional msg shown ingame to player if he cannot enter. You can add extra info',
  `faction` TINYINT unsigned NOT NULL DEFAULT 2 COMMENT '0 = Alliance, 1 = Horde, 2 = Both factions',
  `priority` TINYINT unsigned DEFAULT NULL COMMENT 'Priority order for the requirement, sorted by type. 0 is the highest priority',
  `leader_only` TINYINT NOT NULL DEFAULT 0 COMMENT '0 = check the requirement for the player trying to enter, 1 = check the requirement for the party leader',
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`dungeon_access_id`,`requirement_type`,`requirement_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COMMENT='Add (multiple) requirements before being able to enter a dungeon/raid';

-- Дамп данных таблицы _acore_world.dungeon_access_requirements: 33 rows
DELETE FROM `dungeon_access_requirements`;
/*!40000 ALTER TABLE `dungeon_access_requirements` DISABLE KEYS */;
INSERT INTO `dungeon_access_requirements` (`dungeon_access_id`, `requirement_type`, `requirement_id`, `requirement_note`, `faction`, `priority`, `leader_only`, `comment`) VALUES
	(17, 1, 10285, 'You must complete the quest "Return to Andormu" before entering the Black Morass.', 2, NULL, 0, NULL),
	(18, 2, 30635, NULL, 2, NULL, 0, NULL),
	(18, 1, 10285, 'You must complete the quest "Return to Andormu" and be level 70 before entering the Heroic difficulty of the Black Morass.', 2, NULL, 1, NULL),
	(34, 2, 30622, NULL, 0, NULL, 0, NULL),
	(34, 2, 30637, NULL, 1, NULL, 0, NULL),
	(36, 2, 30622, NULL, 0, NULL, 0, NULL),
	(36, 2, 30637, NULL, 1, NULL, 0, NULL),
	(38, 2, 30622, NULL, 0, NULL, 0, NULL),
	(38, 2, 30637, NULL, 1, NULL, 0, NULL),
	(41, 2, 30623, NULL, 2, NULL, 0, NULL),
	(43, 2, 30623, NULL, 2, NULL, 0, NULL),
	(45, 2, 30623, NULL, 2, NULL, 0, NULL),
	(49, 2, 30634, NULL, 2, NULL, 0, NULL),
	(51, 2, 30634, NULL, 2, NULL, 0, NULL),
	(53, 2, 30634, NULL, 2, NULL, 0, NULL),
	(55, 2, 30633, NULL, 2, NULL, 0, NULL),
	(57, 2, 30633, NULL, 2, NULL, 0, NULL),
	(59, 2, 30633, NULL, 2, NULL, 0, NULL),
	(61, 2, 30633, NULL, 2, NULL, 0, NULL),
	(63, 2, 30635, NULL, 2, NULL, 0, NULL),
	(77, 1, 11492, 'You must complete the quest "Hard to Kill" and be level 70 before entering the Heroic difficulty of the Magisters\' Terrace.', 2, NULL, 0, NULL),
	(104, 0, 4530, NULL, 2, NULL, 0, NULL),
	(105, 0, 4597, NULL, 2, NULL, 0, NULL),
	(110, 0, 3917, NULL, 2, NULL, 0, NULL),
	(111, 0, 3916, NULL, 2, NULL, 0, NULL),
	(114, 1, 24499, 'You must complete the quest "Echoes of Tortured Souls" before entering the Pit of Saron.', 0, NULL, 0, NULL),
	(114, 1, 24511, 'You must complete the quest "Echoes of Tortured Souls" before entering the Pit of Saron.', 1, NULL, 0, NULL),
	(115, 1, 24499, 'You must complete the quest "Echoes of Tortured Souls" and be level 80 before entering the Heroic difficulty of the Pit of Saron.', 0, NULL, 0, NULL),
	(115, 1, 24511, 'You must complete the quest "Echoes of Tortured Souls" and be level 80 before entering the Heroic difficulty of the Pit of Saron.', 1, NULL, 0, NULL),
	(116, 1, 24710, 'You must complete the quest "Deliverance from the Pit" before entering the Halls of Reflection.', 0, NULL, 0, NULL),
	(116, 1, 24712, 'You must complete the quest "Deliverance from the Pit" before entering the Halls of Reflection.', 1, NULL, 0, NULL),
	(117, 1, 24710, 'You must complete the quest "Deliverance from the Pit" and be level 80 before entering the Heroic difficulty of the Halls of Reflection.', 0, NULL, 0, NULL),
	(117, 1, 24712, 'You must complete the quest "Deliverance from the Pit" and be level 80 before entering the Heroic difficulty of the Halls of Reflection.', 1, NULL, 0, NULL);
/*!40000 ALTER TABLE `dungeon_access_requirements` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
