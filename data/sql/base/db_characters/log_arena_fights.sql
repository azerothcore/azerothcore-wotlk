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

-- Дамп структуры для таблица acore_characters.log_arena_fights
DROP TABLE IF EXISTS `log_arena_fights`;
CREATE TABLE IF NOT EXISTS `log_arena_fights` (
  `fight_id` INT unsigned NOT NULL,
  `time` datetime NOT NULL,
  `type` TINYINT unsigned NOT NULL,
  `duration` INT unsigned NOT NULL,
  `winner` INT unsigned NOT NULL,
  `loser` INT unsigned NOT NULL,
  `winner_tr` SMALLINT unsigned NOT NULL,
  `winner_mmr` SMALLINT unsigned NOT NULL,
  `winner_tr_change` SMALLINT NOT NULL,
  `loser_tr` SMALLINT unsigned NOT NULL,
  `loser_mmr` SMALLINT unsigned NOT NULL,
  `loser_tr_change` SMALLINT NOT NULL,
  `currOnline` INT unsigned NOT NULL,
  PRIMARY KEY (`fight_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Дамп данных таблицы acore_characters.log_arena_fights: 0 rows
DELETE FROM `log_arena_fights`;
/*!40000 ALTER TABLE `log_arena_fights` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_arena_fights` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
