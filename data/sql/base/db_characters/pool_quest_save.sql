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

-- Дамп структуры для таблица _acore_characters.pool_quest_save
DROP TABLE IF EXISTS `pool_quest_save`;
CREATE TABLE IF NOT EXISTS `pool_quest_save` (
  `pool_id` INT unsigned NOT NULL DEFAULT 0,
  `quest_id` INT unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`pool_id`,`quest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Дамп данных таблицы _acore_characters.pool_quest_save: ~38 rows (приблизительно)
DELETE FROM `pool_quest_save`;
/*!40000 ALTER TABLE `pool_quest_save` DISABLE KEYS */;
INSERT INTO `pool_quest_save` (`pool_id`, `quest_id`) VALUES
	(348, 24629),
	(349, 14104),
	(350, 13905),
	(351, 13916),
	(352, 11377),
	(353, 11669),
	(354, 13423),
	(356, 11363),
	(357, 11385),
	(358, 14080),
	(359, 14076),
	(360, 14136),
	(361, 14092),
	(362, 12759),
	(363, 14107),
	(380, 12736),
	(381, 12741),
	(382, 12762),
	(384, 13192),
	(385, 13154),
	(386, 12587),
	(5662, 13675),
	(5663, 13762),
	(5664, 13769),
	(5665, 13773),
	(5666, 13778),
	(5667, 13784),
	(5668, 13670),
	(5669, 13603),
	(5670, 13741),
	(5671, 13746),
	(5672, 13759),
	(5673, 13752),
	(5674, 13107),
	(5675, 13114),
	(5676, 13832),
	(5677, 12961),
	(5678, 24581);
/*!40000 ALTER TABLE `pool_quest_save` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
