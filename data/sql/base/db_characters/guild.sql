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

-- Дамп структуры для таблица acore_characters.guild
DROP TABLE IF EXISTS `guild`;
CREATE TABLE IF NOT EXISTS `guild` (
  `guildid` INT unsigned NOT NULL DEFAULT 0,
  `name` varchar(24) NOT NULL DEFAULT '',
  `leaderguid` INT unsigned NOT NULL DEFAULT 0,
  `EmblemStyle` TINYINT unsigned NOT NULL DEFAULT 0,
  `EmblemColor` TINYINT unsigned NOT NULL DEFAULT 0,
  `BorderStyle` TINYINT unsigned NOT NULL DEFAULT 0,
  `BorderColor` TINYINT unsigned NOT NULL DEFAULT 0,
  `BackgroundColor` TINYINT unsigned NOT NULL DEFAULT 0,
  `info` varchar(500) NOT NULL DEFAULT '',
  `motd` varchar(128) NOT NULL DEFAULT '',
  `createdate` INT unsigned NOT NULL DEFAULT 0,
  `BankMoney` BIGINT unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`guildid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Guild System';

-- Дамп данных таблицы acore_characters.guild: ~0 rows (приблизительно)
DELETE FROM `guild`;
/*!40000 ALTER TABLE `guild` DISABLE KEYS */;
/*!40000 ALTER TABLE `guild` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
