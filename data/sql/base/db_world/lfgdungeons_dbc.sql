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

-- Dumping structure for table acore_world.lfgdungeons_dbc
DROP TABLE IF EXISTS `lfgdungeons_dbc`;
CREATE TABLE IF NOT EXISTS `lfgdungeons_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Name_Lang_enUS` text COLLATE utf8mb4_unicode_ci,
  `Name_Lang_enGB` text COLLATE utf8mb4_unicode_ci,
  `Name_Lang_koKR` text COLLATE utf8mb4_unicode_ci,
  `Name_Lang_frFR` text COLLATE utf8mb4_unicode_ci,
  `Name_Lang_deDE` text COLLATE utf8mb4_unicode_ci,
  `Name_Lang_enCN` text COLLATE utf8mb4_unicode_ci,
  `Name_Lang_zhCN` text COLLATE utf8mb4_unicode_ci,
  `Name_Lang_enTW` text COLLATE utf8mb4_unicode_ci,
  `Name_Lang_zhTW` text COLLATE utf8mb4_unicode_ci,
  `Name_Lang_esES` text COLLATE utf8mb4_unicode_ci,
  `Name_Lang_esMX` text COLLATE utf8mb4_unicode_ci,
  `Name_Lang_ruRU` text COLLATE utf8mb4_unicode_ci,
  `Name_Lang_ptPT` text COLLATE utf8mb4_unicode_ci,
  `Name_Lang_ptBR` text COLLATE utf8mb4_unicode_ci,
  `Name_Lang_itIT` text COLLATE utf8mb4_unicode_ci,
  `Name_Lang_Unk` text COLLATE utf8mb4_unicode_ci,
  `Name_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `MinLevel` int NOT NULL DEFAULT '0',
  `MaxLevel` int NOT NULL DEFAULT '0',
  `Target_Level` int NOT NULL DEFAULT '0',
  `Target_Level_Min` int NOT NULL DEFAULT '0',
  `Target_Level_Max` int NOT NULL DEFAULT '0',
  `MapID` int NOT NULL DEFAULT '0',
  `Difficulty` int NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `TypeID` int NOT NULL DEFAULT '0',
  `Faction` int NOT NULL DEFAULT '0',
  `TextureFilename` text COLLATE utf8mb4_unicode_ci,
  `ExpansionLevel` int NOT NULL DEFAULT '0',
  `Order_Index` int NOT NULL DEFAULT '0',
  `Group_Id` int NOT NULL DEFAULT '0',
  `Description_Lang_enUS` text COLLATE utf8mb4_unicode_ci,
  `Description_Lang_enGB` text COLLATE utf8mb4_unicode_ci,
  `Description_Lang_koKR` text COLLATE utf8mb4_unicode_ci,
  `Description_Lang_frFR` text COLLATE utf8mb4_unicode_ci,
  `Description_Lang_deDE` text COLLATE utf8mb4_unicode_ci,
  `Description_Lang_enCN` text COLLATE utf8mb4_unicode_ci,
  `Description_Lang_zhCN` text COLLATE utf8mb4_unicode_ci,
  `Description_Lang_enTW` text COLLATE utf8mb4_unicode_ci,
  `Description_Lang_zhTW` text COLLATE utf8mb4_unicode_ci,
  `Description_Lang_esES` text COLLATE utf8mb4_unicode_ci,
  `Description_Lang_esMX` text COLLATE utf8mb4_unicode_ci,
  `Description_Lang_ruRU` text COLLATE utf8mb4_unicode_ci,
  `Description_Lang_ptPT` text COLLATE utf8mb4_unicode_ci,
  `Description_Lang_ptBR` text COLLATE utf8mb4_unicode_ci,
  `Description_Lang_itIT` text COLLATE utf8mb4_unicode_ci,
  `Description_Lang_Unk` text COLLATE utf8mb4_unicode_ci,
  `Description_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table acore_world.lfgdungeons_dbc: ~0 rows (approximately)
DELETE FROM `lfgdungeons_dbc`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
