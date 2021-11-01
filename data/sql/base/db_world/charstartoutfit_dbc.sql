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

-- Дамп структуры для таблица _acore_world.charstartoutfit_dbc
DROP TABLE IF EXISTS `charstartoutfit_dbc`;
CREATE TABLE IF NOT EXISTS `charstartoutfit_dbc` (
  `ID` INT NOT NULL DEFAULT 0,
  `RaceID` TINYINT unsigned NOT NULL DEFAULT 0,
  `ClassID` TINYINT unsigned NOT NULL DEFAULT 0,
  `SexID` TINYINT unsigned NOT NULL DEFAULT 0,
  `OutfitID` TINYINT unsigned NOT NULL DEFAULT 0,
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
  `ItemID_18` INT NOT NULL DEFAULT 0,
  `ItemID_19` INT NOT NULL DEFAULT 0,
  `ItemID_20` INT NOT NULL DEFAULT 0,
  `ItemID_21` INT NOT NULL DEFAULT 0,
  `ItemID_22` INT NOT NULL DEFAULT 0,
  `ItemID_23` INT NOT NULL DEFAULT 0,
  `ItemID_24` INT NOT NULL DEFAULT 0,
  `DisplayItemID_1` INT NOT NULL DEFAULT 0,
  `DisplayItemID_2` INT NOT NULL DEFAULT 0,
  `DisplayItemID_3` INT NOT NULL DEFAULT 0,
  `DisplayItemID_4` INT NOT NULL DEFAULT 0,
  `DisplayItemID_5` INT NOT NULL DEFAULT 0,
  `DisplayItemID_6` INT NOT NULL DEFAULT 0,
  `DisplayItemID_7` INT NOT NULL DEFAULT 0,
  `DisplayItemID_8` INT NOT NULL DEFAULT 0,
  `DisplayItemID_9` INT NOT NULL DEFAULT 0,
  `DisplayItemID_10` INT NOT NULL DEFAULT 0,
  `DisplayItemID_11` INT NOT NULL DEFAULT 0,
  `DisplayItemID_12` INT NOT NULL DEFAULT 0,
  `DisplayItemID_13` INT NOT NULL DEFAULT 0,
  `DisplayItemID_14` INT NOT NULL DEFAULT 0,
  `DisplayItemID_15` INT NOT NULL DEFAULT 0,
  `DisplayItemID_16` INT NOT NULL DEFAULT 0,
  `DisplayItemID_17` INT NOT NULL DEFAULT 0,
  `DisplayItemID_18` INT NOT NULL DEFAULT 0,
  `DisplayItemID_19` INT NOT NULL DEFAULT 0,
  `DisplayItemID_20` INT NOT NULL DEFAULT 0,
  `DisplayItemID_21` INT NOT NULL DEFAULT 0,
  `DisplayItemID_22` INT NOT NULL DEFAULT 0,
  `DisplayItemID_23` INT NOT NULL DEFAULT 0,
  `DisplayItemID_24` INT NOT NULL DEFAULT 0,
  `InventoryType_1` INT NOT NULL DEFAULT 0,
  `InventoryType_2` INT NOT NULL DEFAULT 0,
  `InventoryType_3` INT NOT NULL DEFAULT 0,
  `InventoryType_4` INT NOT NULL DEFAULT 0,
  `InventoryType_5` INT NOT NULL DEFAULT 0,
  `InventoryType_6` INT NOT NULL DEFAULT 0,
  `InventoryType_7` INT NOT NULL DEFAULT 0,
  `InventoryType_8` INT NOT NULL DEFAULT 0,
  `InventoryType_9` INT NOT NULL DEFAULT 0,
  `InventoryType_10` INT NOT NULL DEFAULT 0,
  `InventoryType_11` INT NOT NULL DEFAULT 0,
  `InventoryType_12` INT NOT NULL DEFAULT 0,
  `InventoryType_13` INT NOT NULL DEFAULT 0,
  `InventoryType_14` INT NOT NULL DEFAULT 0,
  `InventoryType_15` INT NOT NULL DEFAULT 0,
  `InventoryType_16` INT NOT NULL DEFAULT 0,
  `InventoryType_17` INT NOT NULL DEFAULT 0,
  `InventoryType_18` INT NOT NULL DEFAULT 0,
  `InventoryType_19` INT NOT NULL DEFAULT 0,
  `InventoryType_20` INT NOT NULL DEFAULT 0,
  `InventoryType_21` INT NOT NULL DEFAULT 0,
  `InventoryType_22` INT NOT NULL DEFAULT 0,
  `InventoryType_23` INT NOT NULL DEFAULT 0,
  `InventoryType_24` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Дамп данных таблицы _acore_world.charstartoutfit_dbc: 0 rows
DELETE FROM `charstartoutfit_dbc`;
/*!40000 ALTER TABLE `charstartoutfit_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `charstartoutfit_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
