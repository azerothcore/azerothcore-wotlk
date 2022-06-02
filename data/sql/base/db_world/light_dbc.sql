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

-- Dumpar struktur för tabell acore_world.light_dbc
DROP TABLE IF EXISTS `light_dbc`;
CREATE TABLE IF NOT EXISTS `light_dbc` (
  `ID` INT NOT NULL DEFAULT 0,
  `ContinentID` INT NOT NULL DEFAULT 0,
  `X` float NOT NULL DEFAULT 0,
  `Y` float NOT NULL DEFAULT 0,
  `Z` float NOT NULL DEFAULT 0,
  `FalloffStart` float NOT NULL DEFAULT 0,
  `FalloffEnd` float NOT NULL DEFAULT 0,
  `LightParamsID_1` INT NOT NULL DEFAULT 0,
  `LightParamsID_2` INT NOT NULL DEFAULT 0,
  `LightParamsID_3` INT NOT NULL DEFAULT 0,
  `LightParamsID_4` INT NOT NULL DEFAULT 0,
  `LightParamsID_5` INT NOT NULL DEFAULT 0,
  `LightParamsID_6` INT NOT NULL DEFAULT 0,
  `LightParamsID_7` INT NOT NULL DEFAULT 0,
  `LightParamsID_8` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_world.light_dbc: 0 rows
DELETE FROM `light_dbc`;
/*!40000 ALTER TABLE `light_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `light_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
