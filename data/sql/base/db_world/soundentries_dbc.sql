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

-- Дамп структуры для таблица _acore_world.soundentries_dbc
DROP TABLE IF EXISTS `soundentries_dbc`;
CREATE TABLE IF NOT EXISTS `soundentries_dbc` (
  `ID` INT NOT NULL DEFAULT 0,
  `SoundType` INT NOT NULL DEFAULT 0,
  `Name` varchar(100) DEFAULT NULL,
  `File_1` varchar(100) DEFAULT NULL,
  `File_2` varchar(100) DEFAULT NULL,
  `File_3` varchar(100) DEFAULT NULL,
  `File_4` varchar(100) DEFAULT NULL,
  `File_5` varchar(100) DEFAULT NULL,
  `File_6` varchar(100) DEFAULT NULL,
  `File_7` varchar(100) DEFAULT NULL,
  `File_8` varchar(100) DEFAULT NULL,
  `File_9` varchar(100) DEFAULT NULL,
  `File_10` varchar(100) DEFAULT NULL,
  `Freq_1` INT NOT NULL DEFAULT 0,
  `Freq_2` INT NOT NULL DEFAULT 0,
  `Freq_3` INT NOT NULL DEFAULT 0,
  `Freq_4` INT NOT NULL DEFAULT 0,
  `Freq_5` INT NOT NULL DEFAULT 0,
  `Freq_6` INT NOT NULL DEFAULT 0,
  `Freq_7` INT NOT NULL DEFAULT 0,
  `Freq_8` INT NOT NULL DEFAULT 0,
  `Freq_9` INT NOT NULL DEFAULT 0,
  `Freq_10` INT NOT NULL DEFAULT 0,
  `DirectoryBase` varchar(100) DEFAULT NULL,
  `Volumefloat` float NOT NULL DEFAULT 0,
  `Flags` INT NOT NULL DEFAULT 0,
  `MinDistance` float NOT NULL DEFAULT 0,
  `DistanceCutoff` float NOT NULL DEFAULT 0,
  `EAXDef` INT NOT NULL DEFAULT 0,
  `SoundEntriesAdvancedID` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Дамп данных таблицы _acore_world.soundentries_dbc: 0 rows
DELETE FROM `soundentries_dbc`;
/*!40000 ALTER TABLE `soundentries_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `soundentries_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
