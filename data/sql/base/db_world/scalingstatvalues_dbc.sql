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

-- Дамп структуры для таблица acore_world.scalingstatvalues_dbc
DROP TABLE IF EXISTS `scalingstatvalues_dbc`;
CREATE TABLE IF NOT EXISTS `scalingstatvalues_dbc` (
  `ID` INT NOT NULL DEFAULT 0,
  `Charlevel` INT NOT NULL DEFAULT 0,
  `ShoulderBudget` INT NOT NULL DEFAULT 0,
  `TrinketBudget` INT NOT NULL DEFAULT 0,
  `WeaponBudget1H` INT NOT NULL DEFAULT 0,
  `RangedBudget` INT NOT NULL DEFAULT 0,
  `ClothShoulderArmor` INT NOT NULL DEFAULT 0,
  `LeatherShoulderArmor` INT NOT NULL DEFAULT 0,
  `MailShoulderArmor` INT NOT NULL DEFAULT 0,
  `PlateShoulderArmor` INT NOT NULL DEFAULT 0,
  `WeaponDPS1H` INT NOT NULL DEFAULT 0,
  `WeaponDPS2H` INT NOT NULL DEFAULT 0,
  `SpellcasterDPS1H` INT NOT NULL DEFAULT 0,
  `SpellcasterDPS2H` INT NOT NULL DEFAULT 0,
  `RangedDPS` INT NOT NULL DEFAULT 0,
  `WandDPS` INT NOT NULL DEFAULT 0,
  `SpellPower` INT NOT NULL DEFAULT 0,
  `PrimaryBudget` INT NOT NULL DEFAULT 0,
  `TertiaryBudget` INT NOT NULL DEFAULT 0,
  `ClothCloakArmor` INT NOT NULL DEFAULT 0,
  `ClothChestArmor` INT NOT NULL DEFAULT 0,
  `LeatherChestArmor` INT NOT NULL DEFAULT 0,
  `MailChestArmor` INT NOT NULL DEFAULT 0,
  `PlateChestArmor` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Дамп данных таблицы acore_world.scalingstatvalues_dbc: 0 rows
DELETE FROM `scalingstatvalues_dbc`;
/*!40000 ALTER TABLE `scalingstatvalues_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `scalingstatvalues_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
