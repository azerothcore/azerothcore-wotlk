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

-- Dumpar struktur för tabell acore_world.scalingstatvalues_dbc
DROP TABLE IF EXISTS `scalingstatvalues_dbc`;
CREATE TABLE IF NOT EXISTS `scalingstatvalues_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Charlevel` int NOT NULL DEFAULT '0',
  `ShoulderBudget` int NOT NULL DEFAULT '0',
  `TrinketBudget` int NOT NULL DEFAULT '0',
  `WeaponBudget1H` int NOT NULL DEFAULT '0',
  `RangedBudget` int NOT NULL DEFAULT '0',
  `ClothShoulderArmor` int NOT NULL DEFAULT '0',
  `LeatherShoulderArmor` int NOT NULL DEFAULT '0',
  `MailShoulderArmor` int NOT NULL DEFAULT '0',
  `PlateShoulderArmor` int NOT NULL DEFAULT '0',
  `WeaponDPS1H` int NOT NULL DEFAULT '0',
  `WeaponDPS2H` int NOT NULL DEFAULT '0',
  `SpellcasterDPS1H` int NOT NULL DEFAULT '0',
  `SpellcasterDPS2H` int NOT NULL DEFAULT '0',
  `RangedDPS` int NOT NULL DEFAULT '0',
  `WandDPS` int NOT NULL DEFAULT '0',
  `SpellPower` int NOT NULL DEFAULT '0',
  `PrimaryBudget` int NOT NULL DEFAULT '0',
  `TertiaryBudget` int NOT NULL DEFAULT '0',
  `ClothCloakArmor` int NOT NULL DEFAULT '0',
  `ClothChestArmor` int NOT NULL DEFAULT '0',
  `LeatherChestArmor` int NOT NULL DEFAULT '0',
  `MailChestArmor` int NOT NULL DEFAULT '0',
  `PlateChestArmor` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_world.scalingstatvalues_dbc: 0 rows
DELETE FROM `scalingstatvalues_dbc`;
/*!40000 ALTER TABLE `scalingstatvalues_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `scalingstatvalues_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
