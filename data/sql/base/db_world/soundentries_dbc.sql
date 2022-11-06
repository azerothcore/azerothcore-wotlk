-- --------------------------------------------------------
-- Värd:                         127.0.0.1
-- Serverversion:                8.0.28 - MySQL Community Server - GPL
-- Server-OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumpar struktur för tabell acore_world.soundentries_dbc
DROP TABLE IF EXISTS `soundentries_dbc`;
CREATE TABLE IF NOT EXISTS `soundentries_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `SoundType` int NOT NULL DEFAULT '0',
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
  `Freq_1` int NOT NULL DEFAULT '0',
  `Freq_2` int NOT NULL DEFAULT '0',
  `Freq_3` int NOT NULL DEFAULT '0',
  `Freq_4` int NOT NULL DEFAULT '0',
  `Freq_5` int NOT NULL DEFAULT '0',
  `Freq_6` int NOT NULL DEFAULT '0',
  `Freq_7` int NOT NULL DEFAULT '0',
  `Freq_8` int NOT NULL DEFAULT '0',
  `Freq_9` int NOT NULL DEFAULT '0',
  `Freq_10` int NOT NULL DEFAULT '0',
  `DirectoryBase` varchar(100) DEFAULT NULL,
  `Volumefloat` float NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `MinDistance` float NOT NULL DEFAULT '0',
  `DistanceCutoff` float NOT NULL DEFAULT '0',
  `EAXDef` int NOT NULL DEFAULT '0',
  `SoundEntriesAdvancedID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_world.soundentries_dbc: 0 rows
DELETE FROM `soundentries_dbc`;
/*!40000 ALTER TABLE `soundentries_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `soundentries_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
