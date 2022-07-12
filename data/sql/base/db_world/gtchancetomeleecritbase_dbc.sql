-- --------------------------------------------------------
-- Värd:                         127.0.0.1
-- Serverversion:                8.0.28 - MySQL Community Server - GPL
-- Server-OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumpar struktur för tabell acore_world.gtchancetomeleecritbase_dbc
DROP TABLE IF EXISTS `gtchancetomeleecritbase_dbc`;
CREATE TABLE IF NOT EXISTS `gtchancetomeleecritbase_dbc` (
  `ID` INT NOT NULL DEFAULT 0,
  `Data` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=FIXED;

-- Dumpar data för tabell acore_world.gtchancetomeleecritbase_dbc: 11 rows
DELETE FROM `gtchancetomeleecritbase_dbc`;
/*!40000 ALTER TABLE `gtchancetomeleecritbase_dbc` DISABLE KEYS */;
INSERT INTO `gtchancetomeleecritbase_dbc` (`ID`, `Data`) VALUES
	(0, 0.031891),
	(1, 0.032685),
	(2, -0.01532),
	(3, -0.00295),
	(4, 0.031765),
	(5, 0.031891),
	(6, 0.02922),
	(7, 0.03454),
	(8, 0.02622),
	(9, 0.2),
	(10, 0.074755);
/*!40000 ALTER TABLE `gtchancetomeleecritbase_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
