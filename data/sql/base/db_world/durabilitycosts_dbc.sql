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

-- Dumpar struktur för tabell acore_world.durabilitycosts_dbc
DROP TABLE IF EXISTS `durabilitycosts_dbc`;
CREATE TABLE IF NOT EXISTS `durabilitycosts_dbc` (
  `ID` INT NOT NULL DEFAULT 0,
  `WeaponSubClassCost_1` INT NOT NULL DEFAULT 0,
  `WeaponSubClassCost_2` INT NOT NULL DEFAULT 0,
  `WeaponSubClassCost_3` INT NOT NULL DEFAULT 0,
  `WeaponSubClassCost_4` INT NOT NULL DEFAULT 0,
  `WeaponSubClassCost_5` INT NOT NULL DEFAULT 0,
  `WeaponSubClassCost_6` INT NOT NULL DEFAULT 0,
  `WeaponSubClassCost_7` INT NOT NULL DEFAULT 0,
  `WeaponSubClassCost_8` INT NOT NULL DEFAULT 0,
  `WeaponSubClassCost_9` INT NOT NULL DEFAULT 0,
  `WeaponSubClassCost_10` INT NOT NULL DEFAULT 0,
  `WeaponSubClassCost_11` INT NOT NULL DEFAULT 0,
  `WeaponSubClassCost_12` INT NOT NULL DEFAULT 0,
  `WeaponSubClassCost_13` INT NOT NULL DEFAULT 0,
  `WeaponSubClassCost_14` INT NOT NULL DEFAULT 0,
  `WeaponSubClassCost_15` INT NOT NULL DEFAULT 0,
  `WeaponSubClassCost_16` INT NOT NULL DEFAULT 0,
  `WeaponSubClassCost_17` INT NOT NULL DEFAULT 0,
  `WeaponSubClassCost_18` INT NOT NULL DEFAULT 0,
  `WeaponSubClassCost_19` INT NOT NULL DEFAULT 0,
  `WeaponSubClassCost_20` INT NOT NULL DEFAULT 0,
  `WeaponSubClassCost_21` INT NOT NULL DEFAULT 0,
  `ArmorSubClassCost_1` INT NOT NULL DEFAULT 0,
  `ArmorSubClassCost_2` INT NOT NULL DEFAULT 0,
  `ArmorSubClassCost_3` INT NOT NULL DEFAULT 0,
  `ArmorSubClassCost_4` INT NOT NULL DEFAULT 0,
  `ArmorSubClassCost_5` INT NOT NULL DEFAULT 0,
  `ArmorSubClassCost_6` INT NOT NULL DEFAULT 0,
  `ArmorSubClassCost_7` INT NOT NULL DEFAULT 0,
  `ArmorSubClassCost_8` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_world.durabilitycosts_dbc: 0 rows
DELETE FROM `durabilitycosts_dbc`;
/*!40000 ALTER TABLE `durabilitycosts_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `durabilitycosts_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
