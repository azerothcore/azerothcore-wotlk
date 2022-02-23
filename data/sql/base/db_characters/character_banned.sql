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

-- Дамп структуры для таблица acore_characters.character_banned
DROP TABLE IF EXISTS `character_banned`;
CREATE TABLE IF NOT EXISTS `character_banned` (
  `guid` INT unsigned NOT NULL DEFAULT 0 COMMENT 'Global Unique Identifier',
  `bandate` INT unsigned NOT NULL DEFAULT 0,
  `unbandate` INT unsigned NOT NULL DEFAULT 0,
  `bannedby` varchar(50) NOT NULL,
  `banreason` varchar(255) NOT NULL,
  `active` TINYINT unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`guid`,`bandate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Ban List';

-- Дамп данных таблицы acore_characters.character_banned: ~0 rows (приблизительно)
DELETE FROM `character_banned`;
/*!40000 ALTER TABLE `character_banned` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_banned` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
