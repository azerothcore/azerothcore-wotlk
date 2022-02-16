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

-- Дамп структуры для таблица acore_world.cinematiccamera_dbc
DROP TABLE IF EXISTS `cinematiccamera_dbc`;
CREATE TABLE IF NOT EXISTS `cinematiccamera_dbc` (
  `ID` INT NOT NULL DEFAULT 0,
  `model` varchar(100) DEFAULT NULL,
  `soundEntry` INT NOT NULL DEFAULT 0,
  `locationX` float NOT NULL DEFAULT 0,
  `locationY` float NOT NULL DEFAULT 0,
  `locationZ` float NOT NULL DEFAULT 0,
  `rotation` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='Cinematic camera DBC';

-- Дамп данных таблицы acore_world.cinematiccamera_dbc: 0 rows
DELETE FROM `cinematiccamera_dbc`;
/*!40000 ALTER TABLE `cinematiccamera_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `cinematiccamera_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
