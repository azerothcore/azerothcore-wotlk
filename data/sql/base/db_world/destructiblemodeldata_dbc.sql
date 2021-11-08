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

-- Дамп структуры для таблица _acore_world.destructiblemodeldata_dbc
DROP TABLE IF EXISTS `destructiblemodeldata_dbc`;
CREATE TABLE IF NOT EXISTS `destructiblemodeldata_dbc` (
  `ID` INT NOT NULL DEFAULT 0,
  `State0Wmo` INT NOT NULL DEFAULT 0,
  `State0DestructionDoodadSet` INT NOT NULL DEFAULT 0,
  `State0ImpactEffectDoodadSet` INT NOT NULL DEFAULT 0,
  `State0AmbientDoodadSet` INT NOT NULL DEFAULT 0,
  `State1Wmo` INT NOT NULL DEFAULT 0,
  `State1DestructionDoodadSet` INT NOT NULL DEFAULT 0,
  `State1ImpactEffectDoodadSet` INT NOT NULL DEFAULT 0,
  `State1AmbientDoodadSet` INT NOT NULL DEFAULT 0,
  `State2Wmo` INT NOT NULL DEFAULT 0,
  `State2DestructionDoodadSet` INT NOT NULL DEFAULT 0,
  `State2ImpactEffectDoodadSet` INT NOT NULL DEFAULT 0,
  `State2AmbientDoodadSet` INT NOT NULL DEFAULT 0,
  `State3Wmo` INT NOT NULL DEFAULT 0,
  `State3DestructionDoodadSet` INT NOT NULL DEFAULT 0,
  `State3ImpactEffectDoodadSet` INT NOT NULL DEFAULT 0,
  `State3AmbientDoodadSet` INT NOT NULL DEFAULT 0,
  `Field17` INT NOT NULL DEFAULT 0,
  `Field18` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Дамп данных таблицы _acore_world.destructiblemodeldata_dbc: 0 rows
DELETE FROM `destructiblemodeldata_dbc`;
/*!40000 ALTER TABLE `destructiblemodeldata_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `destructiblemodeldata_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
