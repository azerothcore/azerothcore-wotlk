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

-- Dumping structure for table acore_world.liquidtype_dbc
DROP TABLE IF EXISTS `liquidtype_dbc`;
CREATE TABLE IF NOT EXISTS `liquidtype_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Flags` int NOT NULL DEFAULT '0',
  `Type` int NOT NULL DEFAULT '0',
  `SoundID` int NOT NULL DEFAULT '0',
  `SpellID` int NOT NULL DEFAULT '0',
  `MaxDarkenDepth` float NOT NULL DEFAULT '0',
  `FogDarkenintensity` float NOT NULL DEFAULT '0',
  `AmbDarkenintensity` float NOT NULL DEFAULT '0',
  `DirDarkenintensity` float NOT NULL DEFAULT '0',
  `LightID` int NOT NULL DEFAULT '0',
  `ParticleScale` float NOT NULL DEFAULT '0',
  `ParticleMovement` int NOT NULL DEFAULT '0',
  `ParticleTexSlots` int NOT NULL DEFAULT '0',
  `MaterialID` int NOT NULL DEFAULT '0',
  `Texture_1` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Texture_2` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Texture_3` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Texture_4` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Texture_5` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Texture_6` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Color_1` int NOT NULL DEFAULT '0',
  `Color_2` int NOT NULL DEFAULT '0',
  `Float_1` float NOT NULL DEFAULT '0',
  `Float_2` float NOT NULL DEFAULT '0',
  `Float_3` float NOT NULL DEFAULT '0',
  `Float_4` float NOT NULL DEFAULT '0',
  `Float_5` float NOT NULL DEFAULT '0',
  `Float_6` float NOT NULL DEFAULT '0',
  `Float_7` float NOT NULL DEFAULT '0',
  `Float_8` float NOT NULL DEFAULT '0',
  `Float_9` float NOT NULL DEFAULT '0',
  `Float_10` float NOT NULL DEFAULT '0',
  `Float_11` float NOT NULL DEFAULT '0',
  `Float_12` float NOT NULL DEFAULT '0',
  `Float_13` float NOT NULL DEFAULT '0',
  `Float_14` float NOT NULL DEFAULT '0',
  `Float_15` float NOT NULL DEFAULT '0',
  `Float_16` float NOT NULL DEFAULT '0',
  `Float_17` float NOT NULL DEFAULT '0',
  `Float_18` float NOT NULL DEFAULT '0',
  `Int_1` int NOT NULL DEFAULT '0',
  `Int_2` int NOT NULL DEFAULT '0',
  `Int_3` int NOT NULL DEFAULT '0',
  `Int_4` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table acore_world.liquidtype_dbc: ~0 rows (approximately)
DELETE FROM `liquidtype_dbc`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
