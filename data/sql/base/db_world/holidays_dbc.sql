-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.1.0 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.3.0.6589
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table acore_world.holidays_dbc
DROP TABLE IF EXISTS `holidays_dbc`;
CREATE TABLE IF NOT EXISTS `holidays_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Duration_1` int NOT NULL DEFAULT '0',
  `Duration_2` int NOT NULL DEFAULT '0',
  `Duration_3` int NOT NULL DEFAULT '0',
  `Duration_4` int NOT NULL DEFAULT '0',
  `Duration_5` int NOT NULL DEFAULT '0',
  `Duration_6` int NOT NULL DEFAULT '0',
  `Duration_7` int NOT NULL DEFAULT '0',
  `Duration_8` int NOT NULL DEFAULT '0',
  `Duration_9` int NOT NULL DEFAULT '0',
  `Duration_10` int NOT NULL DEFAULT '0',
  `Date_1` int NOT NULL DEFAULT '0',
  `Date_2` int NOT NULL DEFAULT '0',
  `Date_3` int NOT NULL DEFAULT '0',
  `Date_4` int NOT NULL DEFAULT '0',
  `Date_5` int NOT NULL DEFAULT '0',
  `Date_6` int NOT NULL DEFAULT '0',
  `Date_7` int NOT NULL DEFAULT '0',
  `Date_8` int NOT NULL DEFAULT '0',
  `Date_9` int NOT NULL DEFAULT '0',
  `Date_10` int NOT NULL DEFAULT '0',
  `Date_11` int NOT NULL DEFAULT '0',
  `Date_12` int NOT NULL DEFAULT '0',
  `Date_13` int NOT NULL DEFAULT '0',
  `Date_14` int NOT NULL DEFAULT '0',
  `Date_15` int NOT NULL DEFAULT '0',
  `Date_16` int NOT NULL DEFAULT '0',
  `Date_17` int NOT NULL DEFAULT '0',
  `Date_18` int NOT NULL DEFAULT '0',
  `Date_19` int NOT NULL DEFAULT '0',
  `Date_20` int NOT NULL DEFAULT '0',
  `Date_21` int NOT NULL DEFAULT '0',
  `Date_22` int NOT NULL DEFAULT '0',
  `Date_23` int NOT NULL DEFAULT '0',
  `Date_24` int NOT NULL DEFAULT '0',
  `Date_25` int NOT NULL DEFAULT '0',
  `Date_26` int NOT NULL DEFAULT '0',
  `Region` int NOT NULL DEFAULT '0',
  `Looping` int NOT NULL DEFAULT '0',
  `CalendarFlags_1` int NOT NULL DEFAULT '0',
  `CalendarFlags_2` int NOT NULL DEFAULT '0',
  `CalendarFlags_3` int NOT NULL DEFAULT '0',
  `CalendarFlags_4` int NOT NULL DEFAULT '0',
  `CalendarFlags_5` int NOT NULL DEFAULT '0',
  `CalendarFlags_6` int NOT NULL DEFAULT '0',
  `CalendarFlags_7` int NOT NULL DEFAULT '0',
  `CalendarFlags_8` int NOT NULL DEFAULT '0',
  `CalendarFlags_9` int NOT NULL DEFAULT '0',
  `CalendarFlags_10` int NOT NULL DEFAULT '0',
  `HolidayNameID` int NOT NULL DEFAULT '0',
  `HolidayDescriptionID` int NOT NULL DEFAULT '0',
  `TextureFilename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Priority` int NOT NULL DEFAULT '0',
  `CalendarFilterType` int NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table acore_world.holidays_dbc: ~0 rows (approximately)
DELETE FROM `holidays_dbc`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
