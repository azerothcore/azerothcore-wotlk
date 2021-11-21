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

-- Дамп структуры для таблица _acore_characters.version_db_characters
DROP TABLE IF EXISTS `version_db_characters`;
CREATE TABLE IF NOT EXISTS `version_db_characters` (
  `sql_rev` varchar(100) NOT NULL,
  `required_rev` varchar(100) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `2021_10_14_00` bit(1) DEFAULT NULL,
  PRIMARY KEY (`sql_rev`),
  KEY `required` (`required_rev`),
  CONSTRAINT `required` FOREIGN KEY (`required_rev`) REFERENCES `version_db_characters` (`sql_rev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='Last applied sql update to DB';

-- Дамп данных таблицы _acore_characters.version_db_characters: ~6 rows (приблизительно)
DELETE FROM `version_db_characters`;
/*!40000 ALTER TABLE `version_db_characters` DISABLE KEYS */;
INSERT INTO `version_db_characters` (`sql_rev`, `required_rev`, `date`, `2021_10_14_00`) VALUES
	('1557226918417685700', NULL, NULL, NULL),
	('1557608218190967100', NULL, NULL, NULL),
	('1572030074009407852', NULL, NULL, NULL),
	('1572815191193825836', NULL, NULL, NULL),
	('1575656087867346414', NULL, NULL, NULL),
	('1616857517874136100', NULL, NULL, NULL),
	('1617907126348389400', NULL, NULL, NULL),
	('1618660143408049500', NULL, NULL, NULL),
	('1619247484235757300', NULL, NULL, NULL),
	('1621715444570678000', NULL, '2021_05_30_00', NULL),
	('1621780938723425400', NULL, '2021_06_23_00', NULL),
	('1622121508190340200', NULL, NULL, NULL),
	('1622403654219554600', NULL, '2021_06_08_00', NULL),
	('1623572783362357500', NULL, '2021_06_18_00', NULL),
	('1624171619907708300', NULL, '2021_06_22_00', NULL),
	('1624468542752528700', NULL, '2021_06_30_00', NULL),
	('1625236840920068800', NULL, '2021_07_06_00', NULL),
	('1625571576605726121', NULL, '2021_07_08_00', NULL),
	('1626271703991541000', NULL, '2021_07_21_00', NULL),
	('1629988683345293500', NULL, '2021_09_13_00', NULL),
	('1632228952688651200', NULL, '2021_09_25_00', NULL),
	('1634163696773334100', NULL, '2021_10_14_00', NULL);
/*!40000 ALTER TABLE `version_db_characters` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
