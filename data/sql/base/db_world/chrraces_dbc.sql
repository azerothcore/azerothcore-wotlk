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

-- Dumpar struktur för tabell acore_world.chrraces_dbc
DROP TABLE IF EXISTS `chrraces_dbc`;
CREATE TABLE IF NOT EXISTS `chrraces_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `FactionID` int NOT NULL DEFAULT '0',
  `ExplorationSoundID` int NOT NULL DEFAULT '0',
  `MaleDisplayId` int NOT NULL DEFAULT '0',
  `FemaleDisplayId` int NOT NULL DEFAULT '0',
  `ClientPrefix` varchar(100) DEFAULT NULL,
  `BaseLanguage` int NOT NULL DEFAULT '0',
  `CreatureType` int NOT NULL DEFAULT '0',
  `ResSicknessSpellID` int NOT NULL DEFAULT '0',
  `SplashSoundID` int NOT NULL DEFAULT '0',
  `ClientFilestring` varchar(100) DEFAULT NULL,
  `CinematicSequenceID` int NOT NULL DEFAULT '0',
  `Alliance` int NOT NULL DEFAULT '0',
  `Name_Lang_enUS` varchar(100) DEFAULT NULL,
  `Name_Lang_enGB` varchar(100) DEFAULT NULL,
  `Name_Lang_koKR` varchar(100) DEFAULT NULL,
  `Name_Lang_frFR` varchar(100) DEFAULT NULL,
  `Name_Lang_deDE` varchar(100) DEFAULT NULL,
  `Name_Lang_enCN` varchar(100) DEFAULT NULL,
  `Name_Lang_zhCN` varchar(100) DEFAULT NULL,
  `Name_Lang_enTW` varchar(100) DEFAULT NULL,
  `Name_Lang_zhTW` varchar(100) DEFAULT NULL,
  `Name_Lang_esES` varchar(100) DEFAULT NULL,
  `Name_Lang_esMX` varchar(100) DEFAULT NULL,
  `Name_Lang_ruRU` varchar(100) DEFAULT NULL,
  `Name_Lang_ptPT` varchar(100) DEFAULT NULL,
  `Name_Lang_ptBR` varchar(100) DEFAULT NULL,
  `Name_Lang_itIT` varchar(100) DEFAULT NULL,
  `Name_Lang_Unk` varchar(100) DEFAULT NULL,
  `Name_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `Name_Female_Lang_enUS` varchar(100) DEFAULT NULL,
  `Name_Female_Lang_enGB` varchar(100) DEFAULT NULL,
  `Name_Female_Lang_koKR` varchar(100) DEFAULT NULL,
  `Name_Female_Lang_frFR` varchar(100) DEFAULT NULL,
  `Name_Female_Lang_deDE` varchar(100) DEFAULT NULL,
  `Name_Female_Lang_enCN` varchar(100) DEFAULT NULL,
  `Name_Female_Lang_zhCN` varchar(100) DEFAULT NULL,
  `Name_Female_Lang_enTW` varchar(100) DEFAULT NULL,
  `Name_Female_Lang_zhTW` varchar(100) DEFAULT NULL,
  `Name_Female_Lang_esES` varchar(100) DEFAULT NULL,
  `Name_Female_Lang_esMX` varchar(100) DEFAULT NULL,
  `Name_Female_Lang_ruRU` varchar(100) DEFAULT NULL,
  `Name_Female_Lang_ptPT` varchar(100) DEFAULT NULL,
  `Name_Female_Lang_ptBR` varchar(100) DEFAULT NULL,
  `Name_Female_Lang_itIT` varchar(100) DEFAULT NULL,
  `Name_Female_Lang_Unk` varchar(100) DEFAULT NULL,
  `Name_Female_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `Name_Male_Lang_enUS` varchar(100) DEFAULT NULL,
  `Name_Male_Lang_enGB` varchar(100) DEFAULT NULL,
  `Name_Male_Lang_koKR` varchar(100) DEFAULT NULL,
  `Name_Male_Lang_frFR` varchar(100) DEFAULT NULL,
  `Name_Male_Lang_deDE` varchar(100) DEFAULT NULL,
  `Name_Male_Lang_enCN` varchar(100) DEFAULT NULL,
  `Name_Male_Lang_zhCN` varchar(100) DEFAULT NULL,
  `Name_Male_Lang_enTW` varchar(100) DEFAULT NULL,
  `Name_Male_Lang_zhTW` varchar(100) DEFAULT NULL,
  `Name_Male_Lang_esES` varchar(100) DEFAULT NULL,
  `Name_Male_Lang_esMX` varchar(100) DEFAULT NULL,
  `Name_Male_Lang_ruRU` varchar(100) DEFAULT NULL,
  `Name_Male_Lang_ptPT` varchar(100) DEFAULT NULL,
  `Name_Male_Lang_ptBR` varchar(100) DEFAULT NULL,
  `Name_Male_Lang_itIT` varchar(100) DEFAULT NULL,
  `Name_Male_Lang_Unk` varchar(100) DEFAULT NULL,
  `Name_Male_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `FacialHairCustomization_1` varchar(100) DEFAULT NULL,
  `FacialHairCustomization_2` varchar(100) DEFAULT NULL,
  `HairCustomization` varchar(100) DEFAULT NULL,
  `Required_Expansion` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_world.chrraces_dbc: 0 rows
DELETE FROM `chrraces_dbc`;
/*!40000 ALTER TABLE `chrraces_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `chrraces_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
