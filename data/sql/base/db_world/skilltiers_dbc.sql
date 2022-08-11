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

-- Dumpar struktur för tabell acore_world.skilltiers_dbc
DROP TABLE IF EXISTS `skilltiers_dbc`;
CREATE TABLE IF NOT EXISTS `skilltiers_dbc` (
  `ID` INT NOT NULL DEFAULT 0,
  `Cost_1` INT NOT NULL DEFAULT 0,
  `Cost_2` INT NOT NULL DEFAULT 0,
  `Cost_3` INT NOT NULL DEFAULT 0,
  `Cost_4` INT NOT NULL DEFAULT 0,
  `Cost_5` INT NOT NULL DEFAULT 0,
  `Cost_6` INT NOT NULL DEFAULT 0,
  `Cost_7` INT NOT NULL DEFAULT 0,
  `Cost_8` INT NOT NULL DEFAULT 0,
  `Cost_9` INT NOT NULL DEFAULT 0,
  `Cost_10` INT NOT NULL DEFAULT 0,
  `Cost_11` INT NOT NULL DEFAULT 0,
  `Cost_12` INT NOT NULL DEFAULT 0,
  `Cost_13` INT NOT NULL DEFAULT 0,
  `Cost_14` INT NOT NULL DEFAULT 0,
  `Cost_15` INT NOT NULL DEFAULT 0,
  `Cost_16` INT NOT NULL DEFAULT 0,
  `Value_1` INT NOT NULL DEFAULT 0,
  `Value_2` INT NOT NULL DEFAULT 0,
  `Value_3` INT NOT NULL DEFAULT 0,
  `Value_4` INT NOT NULL DEFAULT 0,
  `Value_5` INT NOT NULL DEFAULT 0,
  `Value_6` INT NOT NULL DEFAULT 0,
  `Value_7` INT NOT NULL DEFAULT 0,
  `Value_8` INT NOT NULL DEFAULT 0,
  `Value_9` INT NOT NULL DEFAULT 0,
  `Value_10` INT NOT NULL DEFAULT 0,
  `Value_11` INT NOT NULL DEFAULT 0,
  `Value_12` INT NOT NULL DEFAULT 0,
  `Value_13` INT NOT NULL DEFAULT 0,
  `Value_14` INT NOT NULL DEFAULT 0,
  `Value_15` INT NOT NULL DEFAULT 0,
  `Value_16` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_world.skilltiers_dbc: 0 rows
DELETE FROM `skilltiers_dbc`;
/*!40000 ALTER TABLE `skilltiers_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `skilltiers_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
