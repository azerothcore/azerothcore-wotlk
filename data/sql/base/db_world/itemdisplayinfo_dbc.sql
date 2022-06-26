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

-- Dumpar struktur för tabell acore_world.itemdisplayinfo_dbc
DROP TABLE IF EXISTS `itemdisplayinfo_dbc`;
CREATE TABLE IF NOT EXISTS `itemdisplayinfo_dbc` (
  `ID` INT NOT NULL DEFAULT 0,
  `ModelName_1` VARCHAR(100) DEFAULT NULL,
  `ModelName_2` VARCHAR(100) DEFAULT NULL,
  `ModelTexture_1` VARCHAR(100) DEFAULT NULL,
  `ModelTexture_2` VARCHAR(100) DEFAULT NULL,
  `InventoryIcon_1` VARCHAR(100) DEFAULT NULL,
  `InventoryIcon_2` VARCHAR(100) DEFAULT NULL,
  `GeosetGroup_1` INT NOT NULL DEFAULT 0,
  `GeosetGroup_2` INT NOT NULL DEFAULT 0,
  `GeosetGroup_3` INT NOT NULL DEFAULT 0,
  `Flags` INT NOT NULL DEFAULT 0,
  `SpellVisualID` INT NOT NULL DEFAULT 0,
  `GroupSoundIndex` INT NOT NULL DEFAULT 0,
  `HelmetGeosetVis_1` INT NOT NULL DEFAULT 0,
  `HelmetGeosetVis_2` INT NOT NULL DEFAULT 0,
  `Texture_1` VARCHAR(100) DEFAULT NULL,
  `Texture_2` VARCHAR(100) DEFAULT NULL,
  `Texture_3` VARCHAR(100) DEFAULT NULL,
  `Texture_4` VARCHAR(100) DEFAULT NULL,
  `Texture_5` VARCHAR(100) DEFAULT NULL,
  `Texture_6` VARCHAR(100) DEFAULT NULL,
  `Texture_7` VARCHAR(100) DEFAULT NULL,
  `Texture_8` VARCHAR(100) DEFAULT NULL,
  `ItemVisual` INT NOT NULL DEFAULT 0,
  `ParticleColorID` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_world.itemdisplayinfo_dbc: 0 rows
DELETE FROM `itemdisplayinfo_dbc`;
/*!40000 ALTER TABLE `itemdisplayinfo_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `itemdisplayinfo_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
