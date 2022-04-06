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

-- Дамп структуры для таблица acore_characters.worldstates
DROP TABLE IF EXISTS `worldstates`;
CREATE TABLE IF NOT EXISTS `worldstates` (
  `entry` INT unsigned NOT NULL DEFAULT 0,
  `value` INT unsigned NOT NULL DEFAULT 0,
  `comment` tinytext DEFAULT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Variable Saves';

-- Дамп данных таблицы acore_characters.worldstates: ~10 rows (приблизительно)
DELETE FROM `worldstates`;
/*!40000 ALTER TABLE `worldstates` DISABLE KEYS */;
INSERT INTO `worldstates` (`entry`, `value`, `comment`) VALUES
	(3781, 9000000, NULL),
	(3801, 0, NULL),
	(3802, 1, NULL),
	(20001, 1454691600, 'NextArenaPointDistributionTime'),
	(20002, 1471492800, 'NextWeeklyQuestResetTime'),
	(20003, 1471060800, 'NextBGRandomDailyResetTime'),
	(20004, 0, 'cleaning_flags'),
	(20005, 1471060800, 'NextDailyQuestResetTime'),
	(20006, 1471060800, 'NextGuildDailyResetTime'),
	(20007, 1472702400, 'NextMonthlyQuestResetTime');
/*!40000 ALTER TABLE `worldstates` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
