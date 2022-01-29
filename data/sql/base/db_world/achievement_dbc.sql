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

-- Дамп структуры для таблица acore_world.achievement_dbc
DROP TABLE IF EXISTS `achievement_dbc`;
CREATE TABLE IF NOT EXISTS `achievement_dbc` (
  `ID` INT NOT NULL DEFAULT 0,
  `Faction` INT NOT NULL DEFAULT 0,
  `Instance_Id` INT NOT NULL DEFAULT 0,
  `Supercedes` INT NOT NULL DEFAULT 0,
  `Title_Lang_enUS` varchar(100) DEFAULT NULL,
  `Title_Lang_enGB` varchar(100) DEFAULT NULL,
  `Title_Lang_koKR` varchar(100) DEFAULT NULL,
  `Title_Lang_frFR` varchar(100) DEFAULT NULL,
  `Title_Lang_deDE` varchar(100) DEFAULT NULL,
  `Title_Lang_enCN` varchar(100) DEFAULT NULL,
  `Title_Lang_zhCN` varchar(100) DEFAULT NULL,
  `Title_Lang_enTW` varchar(100) DEFAULT NULL,
  `Title_Lang_zhTW` varchar(100) DEFAULT NULL,
  `Title_Lang_esES` varchar(100) DEFAULT NULL,
  `Title_Lang_esMX` varchar(100) DEFAULT NULL,
  `Title_Lang_ruRU` varchar(100) DEFAULT NULL,
  `Title_Lang_ptPT` varchar(100) DEFAULT NULL,
  `Title_Lang_ptBR` varchar(100) DEFAULT NULL,
  `Title_Lang_itIT` varchar(100) DEFAULT NULL,
  `Title_Lang_Unk` varchar(100) DEFAULT NULL,
  `Title_Lang_Mask` INT unsigned NOT NULL DEFAULT 0,
  `Description_Lang_enUS` varchar(200) DEFAULT NULL,
  `Description_Lang_enGB` varchar(200) DEFAULT NULL,
  `Description_Lang_koKR` varchar(200) DEFAULT NULL,
  `Description_Lang_frFR` varchar(200) DEFAULT NULL,
  `Description_Lang_deDE` varchar(200) DEFAULT NULL,
  `Description_Lang_enCN` varchar(200) DEFAULT NULL,
  `Description_Lang_zhCN` varchar(200) DEFAULT NULL,
  `Description_Lang_enTW` varchar(200) DEFAULT NULL,
  `Description_Lang_zhTW` varchar(200) DEFAULT NULL,
  `Description_Lang_esES` varchar(200) DEFAULT NULL,
  `Description_Lang_esMX` varchar(200) DEFAULT NULL,
  `Description_Lang_ruRU` varchar(200) DEFAULT NULL,
  `Description_Lang_ptPT` varchar(200) DEFAULT NULL,
  `Description_Lang_ptBR` varchar(200) DEFAULT NULL,
  `Description_Lang_itIT` varchar(200) DEFAULT NULL,
  `Description_Lang_Unk` varchar(100) DEFAULT NULL,
  `Description_Lang_Mask` INT unsigned NOT NULL DEFAULT 0,
  `Category` INT NOT NULL DEFAULT 0,
  `Points` INT NOT NULL DEFAULT 0,
  `Ui_Order` INT NOT NULL DEFAULT 0,
  `Flags` INT NOT NULL DEFAULT 0,
  `IconID` INT NOT NULL DEFAULT 0,
  `Reward_Lang_enUS` varchar(100) DEFAULT NULL,
  `Reward_Lang_enGB` varchar(100) DEFAULT NULL,
  `Reward_Lang_koKR` varchar(100) DEFAULT NULL,
  `Reward_Lang_frFR` varchar(100) DEFAULT NULL,
  `Reward_Lang_deDE` varchar(100) DEFAULT NULL,
  `Reward_Lang_enCN` varchar(100) DEFAULT NULL,
  `Reward_Lang_zhCN` varchar(100) DEFAULT NULL,
  `Reward_Lang_enTW` varchar(100) DEFAULT NULL,
  `Reward_Lang_zhTW` varchar(100) DEFAULT NULL,
  `Reward_Lang_esES` varchar(100) DEFAULT NULL,
  `Reward_Lang_esMX` varchar(100) DEFAULT NULL,
  `Reward_Lang_ruRU` varchar(100) DEFAULT NULL,
  `Reward_Lang_ptPT` varchar(100) DEFAULT NULL,
  `Reward_Lang_ptBR` varchar(100) DEFAULT NULL,
  `Reward_Lang_itIT` varchar(100) DEFAULT NULL,
  `Reward_Lang_Unk` varchar(100) DEFAULT NULL,
  `Reward_Lang_Mask` INT unsigned NOT NULL DEFAULT 0,
  `Minimum_Criteria` INT NOT NULL DEFAULT 0,
  `Shares_Criteria` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- Дамп данных таблицы acore_world.achievement_dbc: 3 rows
DELETE FROM `achievement_dbc`;
/*!40000 ALTER TABLE `achievement_dbc` DISABLE KEYS */;
INSERT INTO `achievement_dbc` (`ID`, `Faction`, `Instance_Id`, `Supercedes`, `Title_Lang_enUS`, `Title_Lang_enGB`, `Title_Lang_koKR`, `Title_Lang_frFR`, `Title_Lang_deDE`, `Title_Lang_enCN`, `Title_Lang_zhCN`, `Title_Lang_enTW`, `Title_Lang_zhTW`, `Title_Lang_esES`, `Title_Lang_esMX`, `Title_Lang_ruRU`, `Title_Lang_ptPT`, `Title_Lang_ptBR`, `Title_Lang_itIT`, `Title_Lang_Unk`, `Title_Lang_Mask`, `Description_Lang_enUS`, `Description_Lang_enGB`, `Description_Lang_koKR`, `Description_Lang_frFR`, `Description_Lang_deDE`, `Description_Lang_enCN`, `Description_Lang_zhCN`, `Description_Lang_enTW`, `Description_Lang_zhTW`, `Description_Lang_esES`, `Description_Lang_esMX`, `Description_Lang_ruRU`, `Description_Lang_ptPT`, `Description_Lang_ptBR`, `Description_Lang_itIT`, `Description_Lang_Unk`, `Description_Lang_Mask`, `Category`, `Points`, `Ui_Order`, `Flags`, `IconID`, `Reward_Lang_enUS`, `Reward_Lang_enGB`, `Reward_Lang_koKR`, `Reward_Lang_frFR`, `Reward_Lang_deDE`, `Reward_Lang_enCN`, `Reward_Lang_zhCN`, `Reward_Lang_enTW`, `Reward_Lang_zhTW`, `Reward_Lang_esES`, `Reward_Lang_esMX`, `Reward_Lang_ruRU`, `Reward_Lang_ptPT`, `Reward_Lang_ptBR`, `Reward_Lang_itIT`, `Reward_Lang_Unk`, `Reward_Lang_Mask`, `Minimum_Criteria`, `Shares_Criteria`) VALUES
	(3696, -1, -1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 2, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0),
	(4788, -1, -1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 2, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0),
	(4789, -1, -1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 2, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0);
/*!40000 ALTER TABLE `achievement_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
