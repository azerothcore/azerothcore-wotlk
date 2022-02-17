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

-- Дамп структуры для таблица acore_characters.groups
DROP TABLE IF EXISTS `groups`;
CREATE TABLE IF NOT EXISTS `groups` (
  `guid` INT unsigned NOT NULL,
  `leaderGuid` INT unsigned NOT NULL,
  `lootMethod` TINYINT unsigned NOT NULL,
  `looterGuid` INT unsigned NOT NULL,
  `lootThreshold` TINYINT unsigned NOT NULL,
  `icon1` BIGINT unsigned NOT NULL,
  `icon2` BIGINT unsigned NOT NULL,
  `icon3` BIGINT unsigned NOT NULL,
  `icon4` BIGINT unsigned NOT NULL,
  `icon5` BIGINT unsigned NOT NULL,
  `icon6` BIGINT unsigned NOT NULL,
  `icon7` BIGINT unsigned NOT NULL,
  `icon8` BIGINT unsigned NOT NULL,
  `groupType` TINYINT unsigned NOT NULL,
  `difficulty` TINYINT unsigned NOT NULL DEFAULT 0,
  `raidDifficulty` TINYINT unsigned NOT NULL DEFAULT 0,
  `masterLooterGuid` INT unsigned NOT NULL,
  PRIMARY KEY (`guid`),
  KEY `leaderGuid` (`leaderGuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Groups';

-- Дамп данных таблицы acore_characters.groups: ~0 rows (приблизительно)
DELETE FROM `groups`;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
