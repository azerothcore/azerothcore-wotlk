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

-- Dumpar struktur för tabell acore_world.holidays_dbc
DROP TABLE IF EXISTS `holidays_dbc`;
CREATE TABLE IF NOT EXISTS `holidays_dbc` (
  `ID` INT NOT NULL DEFAULT 0,
  `Duration_1` INT NOT NULL DEFAULT 0,
  `Duration_2` INT NOT NULL DEFAULT 0,
  `Duration_3` INT NOT NULL DEFAULT 0,
  `Duration_4` INT NOT NULL DEFAULT 0,
  `Duration_5` INT NOT NULL DEFAULT 0,
  `Duration_6` INT NOT NULL DEFAULT 0,
  `Duration_7` INT NOT NULL DEFAULT 0,
  `Duration_8` INT NOT NULL DEFAULT 0,
  `Duration_9` INT NOT NULL DEFAULT 0,
  `Duration_10` INT NOT NULL DEFAULT 0,
  `Date_1` INT NOT NULL DEFAULT 0,
  `Date_2` INT NOT NULL DEFAULT 0,
  `Date_3` INT NOT NULL DEFAULT 0,
  `Date_4` INT NOT NULL DEFAULT 0,
  `Date_5` INT NOT NULL DEFAULT 0,
  `Date_6` INT NOT NULL DEFAULT 0,
  `Date_7` INT NOT NULL DEFAULT 0,
  `Date_8` INT NOT NULL DEFAULT 0,
  `Date_9` INT NOT NULL DEFAULT 0,
  `Date_10` INT NOT NULL DEFAULT 0,
  `Date_11` INT NOT NULL DEFAULT 0,
  `Date_12` INT NOT NULL DEFAULT 0,
  `Date_13` INT NOT NULL DEFAULT 0,
  `Date_14` INT NOT NULL DEFAULT 0,
  `Date_15` INT NOT NULL DEFAULT 0,
  `Date_16` INT NOT NULL DEFAULT 0,
  `Date_17` INT NOT NULL DEFAULT 0,
  `Date_18` INT NOT NULL DEFAULT 0,
  `Date_19` INT NOT NULL DEFAULT 0,
  `Date_20` INT NOT NULL DEFAULT 0,
  `Date_21` INT NOT NULL DEFAULT 0,
  `Date_22` INT NOT NULL DEFAULT 0,
  `Date_23` INT NOT NULL DEFAULT 0,
  `Date_24` INT NOT NULL DEFAULT 0,
  `Date_25` INT NOT NULL DEFAULT 0,
  `Date_26` INT NOT NULL DEFAULT 0,
  `Region` INT NOT NULL DEFAULT 0,
  `Looping` INT NOT NULL DEFAULT 0,
  `CalendarFlags_1` INT NOT NULL DEFAULT 0,
  `CalendarFlags_2` INT NOT NULL DEFAULT 0,
  `CalendarFlags_3` INT NOT NULL DEFAULT 0,
  `CalendarFlags_4` INT NOT NULL DEFAULT 0,
  `CalendarFlags_5` INT NOT NULL DEFAULT 0,
  `CalendarFlags_6` INT NOT NULL DEFAULT 0,
  `CalendarFlags_7` INT NOT NULL DEFAULT 0,
  `CalendarFlags_8` INT NOT NULL DEFAULT 0,
  `CalendarFlags_9` INT NOT NULL DEFAULT 0,
  `CalendarFlags_10` INT NOT NULL DEFAULT 0,
  `HolidayNameID` INT NOT NULL DEFAULT 0,
  `HolidayDescriptionID` INT NOT NULL DEFAULT 0,
  `TextureFilename` VARCHAR(100) DEFAULT NULL,
  `Priority` INT NOT NULL DEFAULT 0,
  `CalendarFilterType` INT NOT NULL DEFAULT 0,
  `Flags` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_world.holidays_dbc: 0 rows
DELETE FROM `holidays_dbc`;
/*!40000 ALTER TABLE `holidays_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `holidays_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
