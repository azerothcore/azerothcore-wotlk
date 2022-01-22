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

-- Дамп структуры для таблица _acore_characters.character_queststatus
DROP TABLE IF EXISTS `character_queststatus`;
CREATE TABLE IF NOT EXISTS `character_queststatus` (
  `guid` INT unsigned NOT NULL DEFAULT 0 COMMENT 'Global Unique Identifier',
  `quest` INT unsigned NOT NULL DEFAULT 0 COMMENT 'Quest Identifier',
  `status` TINYINT unsigned NOT NULL DEFAULT 0,
  `explored` TINYINT unsigned NOT NULL DEFAULT 0,
  `timer` INT unsigned NOT NULL DEFAULT 0,
  `mobcount1` SMALLINT unsigned NOT NULL DEFAULT 0,
  `mobcount2` SMALLINT unsigned NOT NULL DEFAULT 0,
  `mobcount3` SMALLINT unsigned NOT NULL DEFAULT 0,
  `mobcount4` SMALLINT unsigned NOT NULL DEFAULT 0,
  `itemcount1` SMALLINT unsigned NOT NULL DEFAULT 0,
  `itemcount2` SMALLINT unsigned NOT NULL DEFAULT 0,
  `itemcount3` SMALLINT unsigned NOT NULL DEFAULT 0,
  `itemcount4` SMALLINT unsigned NOT NULL DEFAULT 0,
  `itemcount5` SMALLINT unsigned NOT NULL DEFAULT 0,
  `itemcount6` SMALLINT unsigned NOT NULL DEFAULT 0,
  `playercount` SMALLINT unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`,`quest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Player System';

-- Дамп данных таблицы _acore_characters.character_queststatus: ~0 rows (приблизительно)
DELETE FROM `character_queststatus`;
/*!40000 ALTER TABLE `character_queststatus` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_queststatus` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
