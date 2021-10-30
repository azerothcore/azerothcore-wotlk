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

-- Дамп структуры для таблица _acore_world.itemset_dbc
DROP TABLE IF EXISTS `itemset_dbc`;
CREATE TABLE IF NOT EXISTS `itemset_dbc` (
  `ID` INT NOT NULL DEFAULT 0,
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
  `ItemID_1` INT NOT NULL DEFAULT 0,
  `ItemID_2` INT NOT NULL DEFAULT 0,
  `ItemID_3` INT NOT NULL DEFAULT 0,
  `ItemID_4` INT NOT NULL DEFAULT 0,
  `ItemID_5` INT NOT NULL DEFAULT 0,
  `ItemID_6` INT NOT NULL DEFAULT 0,
  `ItemID_7` INT NOT NULL DEFAULT 0,
  `ItemID_8` INT NOT NULL DEFAULT 0,
  `ItemID_9` INT NOT NULL DEFAULT 0,
  `ItemID_10` INT NOT NULL DEFAULT 0,
  `ItemID_11` INT NOT NULL DEFAULT 0,
  `ItemID_12` INT NOT NULL DEFAULT 0,
  `ItemID_13` INT NOT NULL DEFAULT 0,
  `ItemID_14` INT NOT NULL DEFAULT 0,
  `ItemID_15` INT NOT NULL DEFAULT 0,
  `ItemID_16` INT NOT NULL DEFAULT 0,
  `ItemID_17` INT NOT NULL DEFAULT 0,
  `SetSpellID_1` INT NOT NULL DEFAULT 0,
  `SetSpellID_2` INT NOT NULL DEFAULT 0,
  `SetSpellID_3` INT NOT NULL DEFAULT 0,
  `SetSpellID_4` INT NOT NULL DEFAULT 0,
  `SetSpellID_5` INT NOT NULL DEFAULT 0,
  `SetSpellID_6` INT NOT NULL DEFAULT 0,
  `SetSpellID_7` INT NOT NULL DEFAULT 0,
  `SetSpellID_8` INT NOT NULL DEFAULT 0,
  `SetThreshold_1` INT NOT NULL DEFAULT 0,
  `SetThreshold_2` INT NOT NULL DEFAULT 0,
  `SetThreshold_3` INT NOT NULL DEFAULT 0,
  `SetThreshold_4` INT NOT NULL DEFAULT 0,
  `SetThreshold_5` INT NOT NULL DEFAULT 0,
  `SetThreshold_6` INT NOT NULL DEFAULT 0,
  `SetThreshold_7` INT NOT NULL DEFAULT 0,
  `SetThreshold_8` INT NOT NULL DEFAULT 0,
  `RequiredSkill` INT NOT NULL DEFAULT 0,
  `RequiredSkillRank` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Дамп данных таблицы _acore_world.itemset_dbc: 0 rows
DELETE FROM `itemset_dbc`;
/*!40000 ALTER TABLE `itemset_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `itemset_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
