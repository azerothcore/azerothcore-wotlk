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

-- Дамп структуры для таблица acore_world.gtchancetospellcritbase_dbc
DROP TABLE IF EXISTS `gtchancetospellcritbase_dbc`;
CREATE TABLE IF NOT EXISTS `gtchancetospellcritbase_dbc` (
  `ID` INT NOT NULL DEFAULT 0,
  `Data` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=FIXED;

-- Дамп данных таблицы acore_world.gtchancetospellcritbase_dbc: 11 rows
DELETE FROM `gtchancetospellcritbase_dbc`;
/*!40000 ALTER TABLE `gtchancetospellcritbase_dbc` DISABLE KEYS */;
INSERT INTO `gtchancetospellcritbase_dbc` (`ID`, `Data`) VALUES
	(0, 0),
	(1, 0.033355),
	(2, 0.03602),
	(3, 0),
	(4, 0.012375),
	(5, 0),
	(6, 0.02201),
	(7, 0.009075),
	(8, 0.017),
	(9, 0.2),
	(10, 0.018515);
/*!40000 ALTER TABLE `gtchancetospellcritbase_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
