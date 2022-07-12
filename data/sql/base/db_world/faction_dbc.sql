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

-- Dumpar struktur för tabell acore_world.faction_dbc
DROP TABLE IF EXISTS `faction_dbc`;
CREATE TABLE IF NOT EXISTS `faction_dbc` (
  `ID` INT NOT NULL DEFAULT 0,
  `ReputationIndex` INT NOT NULL DEFAULT 0,
  `ReputationRaceMask_1` INT NOT NULL DEFAULT 0,
  `ReputationRaceMask_2` INT NOT NULL DEFAULT 0,
  `ReputationRaceMask_3` INT NOT NULL DEFAULT 0,
  `ReputationRaceMask_4` INT NOT NULL DEFAULT 0,
  `ReputationClassMask_1` INT NOT NULL DEFAULT 0,
  `ReputationClassMask_2` INT NOT NULL DEFAULT 0,
  `ReputationClassMask_3` INT NOT NULL DEFAULT 0,
  `ReputationClassMask_4` INT NOT NULL DEFAULT 0,
  `ReputationBase_1` INT NOT NULL DEFAULT 0,
  `ReputationBase_2` INT NOT NULL DEFAULT 0,
  `ReputationBase_3` INT NOT NULL DEFAULT 0,
  `ReputationBase_4` INT NOT NULL DEFAULT 0,
  `ReputationFlags_1` INT NOT NULL DEFAULT 0,
  `ReputationFlags_2` INT NOT NULL DEFAULT 0,
  `ReputationFlags_3` INT NOT NULL DEFAULT 0,
  `ReputationFlags_4` INT NOT NULL DEFAULT 0,
  `ParentFactionID` INT NOT NULL DEFAULT 0,
  `ParentFactionMod_1` float NOT NULL DEFAULT 0,
  `ParentFactionMod_2` float NOT NULL DEFAULT 0,
  `ParentFactionCap_1` INT NOT NULL DEFAULT 0,
  `ParentFactionCap_2` INT NOT NULL DEFAULT 0,
  `Name_Lang_enUS` VARCHAR(100) DEFAULT NULL,
  `Name_Lang_enGB` VARCHAR(100) DEFAULT NULL,
  `Name_Lang_koKR` VARCHAR(100) DEFAULT NULL,
  `Name_Lang_frFR` VARCHAR(100) DEFAULT NULL,
  `Name_Lang_deDE` VARCHAR(100) DEFAULT NULL,
  `Name_Lang_enCN` VARCHAR(100) DEFAULT NULL,
  `Name_Lang_zhCN` VARCHAR(100) DEFAULT NULL,
  `Name_Lang_enTW` VARCHAR(100) DEFAULT NULL,
  `Name_Lang_zhTW` VARCHAR(100) DEFAULT NULL,
  `Name_Lang_esES` VARCHAR(100) DEFAULT NULL,
  `Name_Lang_esMX` VARCHAR(100) DEFAULT NULL,
  `Name_Lang_ruRU` VARCHAR(100) DEFAULT NULL,
  `Name_Lang_ptPT` VARCHAR(100) DEFAULT NULL,
  `Name_Lang_ptBR` VARCHAR(100) DEFAULT NULL,
  `Name_Lang_itIT` VARCHAR(100) DEFAULT NULL,
  `Name_Lang_Unk` VARCHAR(100) DEFAULT NULL,
  `Name_Lang_Mask` INT unsigned NOT NULL DEFAULT 0,
  `Description_Lang_enUS` VARCHAR(300) DEFAULT NULL,
  `Description_Lang_enGB` VARCHAR(300) DEFAULT NULL,
  `Description_Lang_koKR` VARCHAR(300) DEFAULT NULL,
  `Description_Lang_frFR` VARCHAR(300) DEFAULT NULL,
  `Description_Lang_deDE` VARCHAR(300) DEFAULT NULL,
  `Description_Lang_enCN` VARCHAR(300) DEFAULT NULL,
  `Description_Lang_zhCN` VARCHAR(300) DEFAULT NULL,
  `Description_Lang_enTW` VARCHAR(300) DEFAULT NULL,
  `Description_Lang_zhTW` VARCHAR(300) DEFAULT NULL,
  `Description_Lang_esES` VARCHAR(300) DEFAULT NULL,
  `Description_Lang_esMX` VARCHAR(300) DEFAULT NULL,
  `Description_Lang_ruRU` VARCHAR(300) DEFAULT NULL,
  `Description_Lang_ptPT` VARCHAR(300) DEFAULT NULL,
  `Description_Lang_ptBR` VARCHAR(300) DEFAULT NULL,
  `Description_Lang_itIT` VARCHAR(300) DEFAULT NULL,
  `Description_Lang_Unk` VARCHAR(100) DEFAULT NULL,
  `Description_Lang_Mask` INT unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_world.faction_dbc: 0 rows
DELETE FROM `faction_dbc`;
/*!40000 ALTER TABLE `faction_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `faction_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
