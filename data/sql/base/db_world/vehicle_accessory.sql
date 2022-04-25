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

-- Dumpar struktur för tabell acore_world.vehicle_accessory
DROP TABLE IF EXISTS `vehicle_accessory`;
CREATE TABLE IF NOT EXISTS `vehicle_accessory` (
  `guid` MEDIUMINT unsigned NOT NULL DEFAULT 0,
  `accessory_entry` MEDIUMINT unsigned NOT NULL DEFAULT 0,
  `seat_id` TINYINT NOT NULL DEFAULT 0,
  `minion` TINYINT unsigned NOT NULL DEFAULT 0,
  `description` text NOT NULL,
  `summontype` TINYINT unsigned NOT NULL DEFAULT '6' COMMENT 'see enum TempSummonType',
  `summontimer` INT unsigned NOT NULL DEFAULT '30000' COMMENT 'timer, only relevant for certain summontypes',
  PRIMARY KEY (`guid`,`seat_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=FIXED;

-- Dumpar data för tabell acore_world.vehicle_accessory: 0 rows
DELETE FROM `vehicle_accessory`;
/*!40000 ALTER TABLE `vehicle_accessory` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicle_accessory` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
