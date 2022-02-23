-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               10.6.4-MariaDB - mariadb.org binary distribution
-- Операционная система:         Win64
-- HeidiSQL Версия:              11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Дамп структуры для таблица acore_world.faction_dbc
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
  `Name_Lang_Mask` INT unsigned NOT NULL DEFAULT 0,
  `Description_Lang_enUS` varchar(300) DEFAULT NULL,
  `Description_Lang_enGB` varchar(300) DEFAULT NULL,
  `Description_Lang_koKR` varchar(300) DEFAULT NULL,
  `Description_Lang_frFR` varchar(300) DEFAULT NULL,
  `Description_Lang_deDE` varchar(300) DEFAULT NULL,
  `Description_Lang_enCN` varchar(300) DEFAULT NULL,
  `Description_Lang_zhCN` varchar(300) DEFAULT NULL,
  `Description_Lang_enTW` varchar(300) DEFAULT NULL,
  `Description_Lang_zhTW` varchar(300) DEFAULT NULL,
  `Description_Lang_esES` varchar(300) DEFAULT NULL,
  `Description_Lang_esMX` varchar(300) DEFAULT NULL,
  `Description_Lang_ruRU` varchar(300) DEFAULT NULL,
  `Description_Lang_ptPT` varchar(300) DEFAULT NULL,
  `Description_Lang_ptBR` varchar(300) DEFAULT NULL,
  `Description_Lang_itIT` varchar(300) DEFAULT NULL,
  `Description_Lang_Unk` varchar(100) DEFAULT NULL,
  `Description_Lang_Mask` INT unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Дамп данных таблицы acore_world.faction_dbc: 0 rows
DELETE FROM `faction_dbc`;
/*!40000 ALTER TABLE `faction_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `faction_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
