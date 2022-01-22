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

-- Дамп структуры для таблица _acore_world.achievement_criteria_dbc
DROP TABLE IF EXISTS `achievement_criteria_dbc`;
CREATE TABLE IF NOT EXISTS `achievement_criteria_dbc` (
  `ID` INT NOT NULL DEFAULT 0,
  `Achievement_Id` INT NOT NULL DEFAULT 0,
  `Type` INT NOT NULL DEFAULT 0,
  `Asset_Id` INT NOT NULL DEFAULT 0,
  `Quantity` INT NOT NULL DEFAULT 0,
  `Start_Event` INT NOT NULL DEFAULT 0,
  `Start_Asset` INT NOT NULL DEFAULT 0,
  `Fail_Event` INT NOT NULL DEFAULT 0,
  `Fail_Asset` INT NOT NULL DEFAULT 0,
  `Description_Lang_enUS` varchar(100) DEFAULT NULL,
  `Description_Lang_enGB` varchar(100) DEFAULT NULL,
  `Description_Lang_koKR` varchar(100) DEFAULT NULL,
  `Description_Lang_frFR` varchar(100) DEFAULT NULL,
  `Description_Lang_deDE` varchar(100) DEFAULT NULL,
  `Description_Lang_enCN` varchar(100) DEFAULT NULL,
  `Description_Lang_zhCN` varchar(100) DEFAULT NULL,
  `Description_Lang_enTW` varchar(100) DEFAULT NULL,
  `Description_Lang_zhTW` varchar(100) DEFAULT NULL,
  `Description_Lang_esES` varchar(100) DEFAULT NULL,
  `Description_Lang_esMX` varchar(100) DEFAULT NULL,
  `Description_Lang_ruRU` varchar(100) DEFAULT NULL,
  `Description_Lang_ptPT` varchar(100) DEFAULT NULL,
  `Description_Lang_ptBR` varchar(100) DEFAULT NULL,
  `Description_Lang_itIT` varchar(100) DEFAULT NULL,
  `Description_Lang_Unk` varchar(100) DEFAULT NULL,
  `Description_Lang_Mask` INT unsigned NOT NULL DEFAULT 0,
  `Flags` INT NOT NULL DEFAULT 0,
  `Timer_Start_Event` INT NOT NULL DEFAULT 0,
  `Timer_Asset_Id` INT NOT NULL DEFAULT 0,
  `Timer_Time` INT NOT NULL DEFAULT 0,
  `Ui_Order` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- Дамп данных таблицы _acore_world.achievement_criteria_dbc: 0 rows
DELETE FROM `achievement_criteria_dbc`;
/*!40000 ALTER TABLE `achievement_criteria_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `achievement_criteria_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
