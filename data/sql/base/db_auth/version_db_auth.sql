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

-- Дамп структуры для таблица acore_auth.version_db_auth
DROP TABLE IF EXISTS `version_db_auth`;
CREATE TABLE IF NOT EXISTS `version_db_auth` (
  `sql_rev` varchar(100) NOT NULL,
  `required_rev` varchar(100) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `2021_11_06_00` bit(1) DEFAULT NULL,
  PRIMARY KEY (`sql_rev`),
  KEY `required` (`required_rev`),
  CONSTRAINT `required` FOREIGN KEY (`required_rev`) REFERENCES `version_db_auth` (`sql_rev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='Last applied sql update to DB';

-- Дамп данных таблицы acore_auth.version_db_auth: ~10 rows (приблизительно)
DELETE FROM `version_db_auth`;
/*!40000 ALTER TABLE `version_db_auth` DISABLE KEYS */;
INSERT INTO `version_db_auth` (`sql_rev`, `required_rev`, `date`, `2021_11_06_00`) VALUES
	('1554142988374631100', NULL, NULL, NULL),
	('1579213352894781043', NULL, NULL, NULL),
	('1609867708436603000', NULL, NULL, NULL),
	('1615629613255169700', NULL, NULL, NULL),
	('1620079951672711500', NULL, NULL, NULL),
	('1620114805872279900', NULL, NULL, NULL),
	('1620146306002634000', NULL, '2021_06_17_00', NULL),
	('1621715473238990700', NULL, '2021_05_30_00', NULL),
	('1634163668021762900', NULL, '2021_10_14_00', NULL),
	('1635587640506554000', NULL, '2021_11_06_00', NULL);
/*!40000 ALTER TABLE `version_db_auth` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
