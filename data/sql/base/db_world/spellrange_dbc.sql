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

-- Дамп структуры для таблица _acore_world.spellrange_dbc
DROP TABLE IF EXISTS `spellrange_dbc`;
CREATE TABLE IF NOT EXISTS `spellrange_dbc` (
  `ID` INT NOT NULL DEFAULT 0,
  `RangeMin_1` float NOT NULL DEFAULT 0,
  `RangeMin_2` float NOT NULL DEFAULT 0,
  `RangeMax_1` float NOT NULL DEFAULT 0,
  `RangeMax_2` float NOT NULL DEFAULT 0,
  `Flags` INT NOT NULL DEFAULT 0,
  `DisplayName_Lang_enUS` text DEFAULT NULL,
  `DisplayName_Lang_enGB` text DEFAULT NULL,
  `DisplayName_Lang_koKR` text DEFAULT NULL,
  `DisplayName_Lang_frFR` text DEFAULT NULL,
  `DisplayName_Lang_deDE` text DEFAULT NULL,
  `DisplayName_Lang_enCN` text DEFAULT NULL,
  `DisplayName_Lang_zhCN` text DEFAULT NULL,
  `DisplayName_Lang_enTW` text DEFAULT NULL,
  `DisplayName_Lang_zhTW` text DEFAULT NULL,
  `DisplayName_Lang_esES` text DEFAULT NULL,
  `DisplayName_Lang_esMX` text DEFAULT NULL,
  `DisplayName_Lang_ruRU` text DEFAULT NULL,
  `DisplayName_Lang_ptPT` text DEFAULT NULL,
  `DisplayName_Lang_ptBR` text DEFAULT NULL,
  `DisplayName_Lang_itIT` text DEFAULT NULL,
  `DisplayName_Lang_Unk` text DEFAULT NULL,
  `DisplayName_Lang_Mask` INT unsigned NOT NULL DEFAULT 0,
  `DisplayNameShort_Lang_enUS` text DEFAULT NULL,
  `DisplayNameShort_Lang_enGB` text DEFAULT NULL,
  `DisplayNameShort_Lang_koKR` text DEFAULT NULL,
  `DisplayNameShort_Lang_frFR` text DEFAULT NULL,
  `DisplayNameShort_Lang_deDE` text DEFAULT NULL,
  `DisplayNameShort_Lang_enCN` text DEFAULT NULL,
  `DisplayNameShort_Lang_zhCN` text DEFAULT NULL,
  `DisplayNameShort_Lang_enTW` text DEFAULT NULL,
  `DisplayNameShort_Lang_zhTW` text DEFAULT NULL,
  `DisplayNameShort_Lang_esES` text DEFAULT NULL,
  `DisplayNameShort_Lang_esMX` text DEFAULT NULL,
  `DisplayNameShort_Lang_ruRU` text DEFAULT NULL,
  `DisplayNameShort_Lang_ptPT` text DEFAULT NULL,
  `DisplayNameShort_Lang_ptBR` text DEFAULT NULL,
  `DisplayNameShort_Lang_itIT` text DEFAULT NULL,
  `DisplayNameShort_Lang_Unk` text DEFAULT NULL,
  `DisplayNameShort_Lang_Mask` INT unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Дамп данных таблицы _acore_world.spellrange_dbc: 0 rows
DELETE FROM `spellrange_dbc`;
/*!40000 ALTER TABLE `spellrange_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `spellrange_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
