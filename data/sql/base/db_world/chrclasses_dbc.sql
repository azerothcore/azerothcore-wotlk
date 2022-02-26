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

-- Дамп структуры для таблица acore_world.chrclasses_dbc
DROP TABLE IF EXISTS `chrclasses_dbc`;
CREATE TABLE IF NOT EXISTS `chrclasses_dbc` (
  `ID` INT NOT NULL DEFAULT 0,
  `Field01` INT NOT NULL DEFAULT 0,
  `DisplayPower` INT NOT NULL DEFAULT 0,
  `PetNameToken` INT NOT NULL DEFAULT 0,
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
  `Name_Female_Lang_Mask` INT unsigned NOT NULL DEFAULT 0,
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
  `Name_Male_Lang_Mask` INT unsigned NOT NULL DEFAULT 0,
  `Filename` varchar(100) DEFAULT NULL,
  `SpellClassSet` INT NOT NULL DEFAULT 0,
  `Flags` INT NOT NULL DEFAULT 0,
  `CinematicSequenceID` INT NOT NULL DEFAULT 0,
  `Required_Expansion` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Дамп данных таблицы acore_world.chrclasses_dbc: 0 rows
DELETE FROM `chrclasses_dbc`;
/*!40000 ALTER TABLE `chrclasses_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `chrclasses_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
