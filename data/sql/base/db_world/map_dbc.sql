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

-- Дамп структуры для таблица _acore_world.map_dbc
DROP TABLE IF EXISTS `map_dbc`;
CREATE TABLE IF NOT EXISTS `map_dbc` (
  `ID` INT NOT NULL DEFAULT 0,
  `Directory` varchar(100) DEFAULT NULL,
  `InstanceType` INT NOT NULL DEFAULT 0,
  `Flags` INT NOT NULL DEFAULT 0,
  `PVP` INT NOT NULL DEFAULT 0,
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
  `MapName_Lang_Mask` INT unsigned NOT NULL DEFAULT 0,
  `AreaTableID` INT NOT NULL DEFAULT 0,
  `MapDescription0_Lang_enUS` text DEFAULT NULL,
  `MapDescription0_Lang_enGB` text DEFAULT NULL,
  `MapDescription0_Lang_koKR` text DEFAULT NULL,
  `MapDescription0_Lang_frFR` text DEFAULT NULL,
  `MapDescription0_Lang_deDE` text DEFAULT NULL,
  `MapDescription0_Lang_enCN` text DEFAULT NULL,
  `MapDescription0_Lang_zhCN` text DEFAULT NULL,
  `MapDescription0_Lang_enTW` text DEFAULT NULL,
  `MapDescription0_Lang_zhTW` text DEFAULT NULL,
  `MapDescription0_Lang_esES` text DEFAULT NULL,
  `MapDescription0_Lang_esMX` text DEFAULT NULL,
  `MapDescription0_Lang_ruRU` text DEFAULT NULL,
  `MapDescription0_Lang_ptPT` text DEFAULT NULL,
  `MapDescription0_Lang_ptBR` text DEFAULT NULL,
  `MapDescription0_Lang_itIT` text DEFAULT NULL,
  `MapDescription0_Lang_Unk` varchar(100) DEFAULT NULL,
  `MapDescription0_Lang_Mask` INT unsigned NOT NULL DEFAULT 0,
  `MapDescription1_Lang_enUS` text DEFAULT NULL,
  `MapDescription1_Lang_enGB` text DEFAULT NULL,
  `MapDescription1_Lang_koKR` text DEFAULT NULL,
  `MapDescription1_Lang_frFR` text DEFAULT NULL,
  `MapDescription1_Lang_deDE` text DEFAULT NULL,
  `MapDescription1_Lang_enCN` text DEFAULT NULL,
  `MapDescription1_Lang_zhCN` text DEFAULT NULL,
  `MapDescription1_Lang_enTW` text DEFAULT NULL,
  `MapDescription1_Lang_zhTW` text DEFAULT NULL,
  `MapDescription1_Lang_esES` text DEFAULT NULL,
  `MapDescription1_Lang_esMX` text DEFAULT NULL,
  `MapDescription1_Lang_ruRU` text DEFAULT NULL,
  `MapDescription1_Lang_ptPT` text DEFAULT NULL,
  `MapDescription1_Lang_ptBR` text DEFAULT NULL,
  `MapDescription1_Lang_itIT` text DEFAULT NULL,
  `MapDescription1_Lang_Unk` varchar(100) DEFAULT NULL,
  `MapDescription1_Lang_Mask` INT unsigned NOT NULL DEFAULT 0,
  `LoadingScreenID` INT NOT NULL DEFAULT 0,
  `MinimapIconScale` float NOT NULL DEFAULT 0,
  `CorpseMapID` INT NOT NULL DEFAULT 0,
  `CorpseX` float NOT NULL DEFAULT 0,
  `CorpseY` float NOT NULL DEFAULT 0,
  `TimeOfDayOverride` INT NOT NULL DEFAULT 0,
  `ExpansionID` INT NOT NULL DEFAULT 0,
  `RaidOffset` INT NOT NULL DEFAULT 0,
  `MaxPlayers` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Дамп данных таблицы _acore_world.map_dbc: 0 rows
DELETE FROM `map_dbc`;
/*!40000 ALTER TABLE `map_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `map_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
