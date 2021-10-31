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

-- Дамп структуры для таблица _acore_world.scalingstatdistribution_dbc
DROP TABLE IF EXISTS `scalingstatdistribution_dbc`;
CREATE TABLE IF NOT EXISTS `scalingstatdistribution_dbc` (
  `ID` INT NOT NULL DEFAULT 0,
  `StatID_1` INT NOT NULL DEFAULT 0,
  `StatID_2` INT NOT NULL DEFAULT 0,
  `StatID_3` INT NOT NULL DEFAULT 0,
  `StatID_4` INT NOT NULL DEFAULT 0,
  `StatID_5` INT NOT NULL DEFAULT 0,
  `StatID_6` INT NOT NULL DEFAULT 0,
  `StatID_7` INT NOT NULL DEFAULT 0,
  `StatID_8` INT NOT NULL DEFAULT 0,
  `StatID_9` INT NOT NULL DEFAULT 0,
  `StatID_10` INT NOT NULL DEFAULT 0,
  `Bonus_1` INT NOT NULL DEFAULT 0,
  `Bonus_2` INT NOT NULL DEFAULT 0,
  `Bonus_3` INT NOT NULL DEFAULT 0,
  `Bonus_4` INT NOT NULL DEFAULT 0,
  `Bonus_5` INT NOT NULL DEFAULT 0,
  `Bonus_6` INT NOT NULL DEFAULT 0,
  `Bonus_7` INT NOT NULL DEFAULT 0,
  `Bonus_8` INT NOT NULL DEFAULT 0,
  `Bonus_9` INT NOT NULL DEFAULT 0,
  `Bonus_10` INT NOT NULL DEFAULT 0,
  `Maxlevel` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Дамп данных таблицы _acore_world.scalingstatdistribution_dbc: 0 rows
DELETE FROM `scalingstatdistribution_dbc`;
/*!40000 ALTER TABLE `scalingstatdistribution_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `scalingstatdistribution_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
