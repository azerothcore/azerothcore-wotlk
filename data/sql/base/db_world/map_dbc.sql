-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.29 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.0.0.6468
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table acore_world.map_dbc
DROP TABLE IF EXISTS `map_dbc`;
CREATE TABLE IF NOT EXISTS `map_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Directory` varchar(100) DEFAULT NULL,
  `InstanceType` int NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `PVP` int NOT NULL DEFAULT '0',
  `MapName_Lang_enUS` varchar(100) DEFAULT NULL,
  `MapName_Lang_enGB` varchar(100) DEFAULT NULL,
  `MapName_Lang_koKR` varchar(100) DEFAULT NULL,
  `MapName_Lang_frFR` varchar(100) DEFAULT NULL,
  `MapName_Lang_deDE` varchar(100) DEFAULT NULL,
  `MapName_Lang_enCN` varchar(100) DEFAULT NULL,
  `MapName_Lang_zhCN` varchar(100) DEFAULT NULL,
  `MapName_Lang_enTW` varchar(100) DEFAULT NULL,
  `MapName_Lang_zhTW` varchar(100) DEFAULT NULL,
  `MapName_Lang_esES` varchar(100) DEFAULT NULL,
  `MapName_Lang_esMX` varchar(100) DEFAULT NULL,
  `MapName_Lang_ruRU` varchar(100) DEFAULT NULL,
  `MapName_Lang_ptPT` varchar(100) DEFAULT NULL,
  `MapName_Lang_ptBR` varchar(100) DEFAULT NULL,
  `MapName_Lang_itIT` varchar(100) DEFAULT NULL,
  `MapName_Lang_Unk` varchar(100) DEFAULT NULL,
  `MapName_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `AreaTableID` int NOT NULL DEFAULT '0',
  `MapDescription0_Lang_enUS` text,
  `MapDescription0_Lang_enGB` text,
  `MapDescription0_Lang_koKR` text,
  `MapDescription0_Lang_frFR` text,
  `MapDescription0_Lang_deDE` text,
  `MapDescription0_Lang_enCN` text,
  `MapDescription0_Lang_zhCN` text,
  `MapDescription0_Lang_enTW` text,
  `MapDescription0_Lang_zhTW` text,
  `MapDescription0_Lang_esES` text,
  `MapDescription0_Lang_esMX` text,
  `MapDescription0_Lang_ruRU` text,
  `MapDescription0_Lang_ptPT` text,
  `MapDescription0_Lang_ptBR` text,
  `MapDescription0_Lang_itIT` text,
  `MapDescription0_Lang_Unk` varchar(100) DEFAULT NULL,
  `MapDescription0_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `MapDescription1_Lang_enUS` text,
  `MapDescription1_Lang_enGB` text,
  `MapDescription1_Lang_koKR` text,
  `MapDescription1_Lang_frFR` text,
  `MapDescription1_Lang_deDE` text,
  `MapDescription1_Lang_enCN` text,
  `MapDescription1_Lang_zhCN` text,
  `MapDescription1_Lang_enTW` text,
  `MapDescription1_Lang_zhTW` text,
  `MapDescription1_Lang_esES` text,
  `MapDescription1_Lang_esMX` text,
  `MapDescription1_Lang_ruRU` text,
  `MapDescription1_Lang_ptPT` text,
  `MapDescription1_Lang_ptBR` text,
  `MapDescription1_Lang_itIT` text,
  `MapDescription1_Lang_Unk` varchar(100) DEFAULT NULL,
  `MapDescription1_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `LoadingScreenID` int NOT NULL DEFAULT '0',
  `MinimapIconScale` float NOT NULL DEFAULT '0',
  `CorpseMapID` int NOT NULL DEFAULT '0',
  `CorpseX` float NOT NULL DEFAULT '0',
  `CorpseY` float NOT NULL DEFAULT '0',
  `TimeOfDayOverride` int NOT NULL DEFAULT '0',
  `ExpansionID` int NOT NULL DEFAULT '0',
  `RaidOffset` int NOT NULL DEFAULT '0',
  `MaxPlayers` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Dumping data for table acore_world.map_dbc: 0 rows
DELETE FROM `map_dbc`;
/*!40000 ALTER TABLE `map_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `map_dbc` ENABLE KEYS */;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
