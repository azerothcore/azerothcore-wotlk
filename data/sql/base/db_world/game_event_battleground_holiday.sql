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

-- Дамп структуры для таблица _acore_world.game_event_battleground_holiday
DROP TABLE IF EXISTS `game_event_battleground_holiday`;
CREATE TABLE IF NOT EXISTS `game_event_battleground_holiday` (
  `eventEntry` TINYINT unsigned NOT NULL COMMENT 'Entry of the game event',
  `bgflag` INT unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`eventEntry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Дамп данных таблицы _acore_world.game_event_battleground_holiday: 6 rows
DELETE FROM `game_event_battleground_holiday`;
/*!40000 ALTER TABLE `game_event_battleground_holiday` DISABLE KEYS */;
INSERT INTO `game_event_battleground_holiday` (`eventEntry`, `bgflag`) VALUES
	(18, 2),
	(19, 4),
	(20, 8),
	(21, 128),
	(53, 512),
	(54, 1073741824);
/*!40000 ALTER TABLE `game_event_battleground_holiday` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
