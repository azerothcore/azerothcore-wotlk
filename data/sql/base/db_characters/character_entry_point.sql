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

-- Дамп структуры для таблица acore_characters.character_entry_point
DROP TABLE IF EXISTS `character_entry_point`;
CREATE TABLE IF NOT EXISTS `character_entry_point` (
  `guid` INT unsigned NOT NULL DEFAULT 0 COMMENT 'Global Unique Identifier',
  `joinX` float NOT NULL DEFAULT 0,
  `joinY` float NOT NULL DEFAULT 0,
  `joinZ` float NOT NULL DEFAULT 0,
  `joinO` float NOT NULL DEFAULT 0,
  `joinMapId` INT unsigned NOT NULL DEFAULT 0 COMMENT 'Map Identifier',
  `taxiPath` text DEFAULT NULL,
  `mountSpell` INT unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Player System';

-- Дамп данных таблицы acore_characters.character_entry_point: ~0 rows (приблизительно)
DELETE FROM `character_entry_point`;
/*!40000 ALTER TABLE `character_entry_point` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_entry_point` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
