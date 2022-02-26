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

-- Дамп структуры для таблица acore_world.game_weather
DROP TABLE IF EXISTS `game_weather`;
CREATE TABLE IF NOT EXISTS `game_weather` (
  `zone` MEDIUMINT unsigned NOT NULL DEFAULT 0,
  `spring_rain_chance` TINYINT unsigned NOT NULL DEFAULT 25,
  `spring_snow_chance` TINYINT unsigned NOT NULL DEFAULT 25,
  `spring_storm_chance` TINYINT unsigned NOT NULL DEFAULT 25,
  `summer_rain_chance` TINYINT unsigned NOT NULL DEFAULT 25,
  `summer_snow_chance` TINYINT unsigned NOT NULL DEFAULT 25,
  `summer_storm_chance` TINYINT unsigned NOT NULL DEFAULT 25,
  `fall_rain_chance` TINYINT unsigned NOT NULL DEFAULT 25,
  `fall_snow_chance` TINYINT unsigned NOT NULL DEFAULT 25,
  `fall_storm_chance` TINYINT unsigned NOT NULL DEFAULT 25,
  `winter_rain_chance` TINYINT unsigned NOT NULL DEFAULT 25,
  `winter_snow_chance` TINYINT unsigned NOT NULL DEFAULT 25,
  `winter_storm_chance` TINYINT unsigned NOT NULL DEFAULT 25,
  `ScriptName` char(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`zone`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=FIXED COMMENT='Weather System';

-- Дамп данных таблицы acore_world.game_weather: 35 rows
DELETE FROM `game_weather`;
/*!40000 ALTER TABLE `game_weather` DISABLE KEYS */;
INSERT INTO `game_weather` (`zone`, `spring_rain_chance`, `spring_snow_chance`, `spring_storm_chance`, `summer_rain_chance`, `summer_snow_chance`, `summer_storm_chance`, `fall_rain_chance`, `fall_snow_chance`, `fall_storm_chance`, `winter_rain_chance`, `winter_snow_chance`, `winter_storm_chance`, `ScriptName`) VALUES
	(1, 0, 25, 0, 0, 15, 0, 0, 25, 0, 0, 25, 0, ''),
	(3, 0, 0, 20, 0, 0, 20, 0, 0, 20, 0, 0, 15, ''),
	(10, 15, 0, 0, 15, 0, 0, 20, 0, 0, 15, 0, 0, ''),
	(11, 25, 0, 0, 15, 0, 0, 25, 0, 0, 25, 0, 0, ''),
	(12, 20, 0, 0, 15, 0, 0, 20, 0, 0, 20, 0, 0, ''),
	(15, 25, 0, 0, 20, 0, 0, 25, 0, 0, 25, 0, 0, ''),
	(28, 10, 0, 0, 15, 0, 0, 15, 0, 0, 10, 0, 0, ''),
	(33, 20, 0, 0, 25, 0, 0, 25, 0, 0, 20, 0, 0, ''),
	(36, 0, 20, 0, 0, 20, 0, 0, 25, 0, 0, 30, 0, ''),
	(38, 15, 0, 0, 15, 0, 0, 15, 0, 0, 15, 0, 0, ''),
	(41, 15, 0, 0, 5, 0, 0, 15, 0, 0, 15, 0, 0, ''),
	(44, 15, 0, 0, 15, 0, 0, 15, 0, 0, 15, 0, 0, ''),
	(45, 23, 0, 0, 15, 0, 0, 23, 0, 0, 23, 0, 0, ''),
	(47, 10, 0, 0, 10, 0, 0, 15, 0, 0, 10, 0, 0, ''),
	(85, 20, 0, 0, 15, 0, 0, 20, 0, 0, 20, 0, 0, ''),
	(139, 10, 0, 0, 15, 0, 0, 15, 0, 0, 10, 0, 0, ''),
	(141, 15, 0, 0, 5, 0, 0, 15, 0, 0, 15, 0, 0, ''),
	(148, 15, 0, 0, 10, 0, 0, 20, 0, 0, 15, 0, 0, ''),
	(215, 15, 0, 0, 10, 0, 0, 20, 0, 0, 15, 0, 0, ''),
	(267, 15, 0, 0, 10, 0, 0, 15, 0, 0, 15, 0, 0, ''),
	(357, 15, 0, 0, 15, 0, 0, 15, 0, 0, 15, 0, 0, ''),
	(405, 10, 0, 0, 5, 0, 0, 5, 0, 0, 5, 0, 0, ''),
	(440, 0, 0, 15, 0, 0, 15, 0, 0, 15, 0, 0, 15, ''),
	(490, 15, 0, 0, 10, 0, 0, 20, 0, 0, 15, 0, 0, ''),
	(618, 0, 25, 0, 0, 20, 0, 0, 20, 0, 0, 25, 0, ''),
	(796, 5, 0, 0, 10, 0, 0, 25, 0, 0, 5, 0, 0, ''),
	(1377, 0, 0, 20, 0, 0, 25, 0, 0, 20, 0, 0, 15, ''),
	(1977, 15, 0, 0, 5, 0, 0, 15, 0, 0, 15, 0, 0, ''),
	(2017, 5, 0, 0, 5, 0, 0, 5, 0, 0, 5, 0, 0, ''),
	(2597, 0, 15, 0, 0, 15, 0, 0, 20, 0, 0, 25, 0, ''),
	(3358, 10, 0, 0, 10, 0, 0, 10, 0, 0, 10, 0, 0, ''),
	(3428, 0, 0, 20, 0, 0, 20, 0, 0, 20, 0, 0, 20, ''),
	(3429, 0, 0, 20, 0, 0, 20, 0, 0, 20, 0, 0, 20, ''),
	(3521, 10, 0, 0, 15, 0, 0, 20, 0, 0, 10, 0, 0, ''),
	(4080, 20, 0, 0, 20, 0, 0, 20, 0, 0, 10, 0, 0, '');
/*!40000 ALTER TABLE `game_weather` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
