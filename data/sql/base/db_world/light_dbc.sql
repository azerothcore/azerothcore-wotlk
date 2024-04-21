-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.1.0 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.3.0.6589
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table acore_world.light_dbc
DROP TABLE IF EXISTS `light_dbc`;
CREATE TABLE IF NOT EXISTS `light_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `ContinentID` int NOT NULL DEFAULT '0',
  `X` float NOT NULL DEFAULT '0',
  `Y` float NOT NULL DEFAULT '0',
  `Z` float NOT NULL DEFAULT '0',
  `FalloffStart` float NOT NULL DEFAULT '0',
  `FalloffEnd` float NOT NULL DEFAULT '0',
  `LightParamsID_1` int NOT NULL DEFAULT '0',
  `LightParamsID_2` int NOT NULL DEFAULT '0',
  `LightParamsID_3` int NOT NULL DEFAULT '0',
  `LightParamsID_4` int NOT NULL DEFAULT '0',
  `LightParamsID_5` int NOT NULL DEFAULT '0',
  `LightParamsID_6` int NOT NULL DEFAULT '0',
  `LightParamsID_7` int NOT NULL DEFAULT '0',
  `LightParamsID_8` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table acore_world.light_dbc: ~0 rows (approximately)
DELETE FROM `light_dbc`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
