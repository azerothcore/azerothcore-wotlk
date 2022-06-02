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

-- Dumpar struktur för tabell acore_world.gameobject_addon
DROP TABLE IF EXISTS `gameobject_addon`;
CREATE TABLE IF NOT EXISTS `gameobject_addon` (
  `guid` INT unsigned NOT NULL DEFAULT 0,
  `invisibilityType` TINYINT unsigned NOT NULL DEFAULT 0,
  `invisibilityValue` INT unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_world.gameobject_addon: 32 rows
DELETE FROM `gameobject_addon`;
/*!40000 ALTER TABLE `gameobject_addon` DISABLE KEYS */;
INSERT INTO `gameobject_addon` (`guid`, `invisibilityType`, `invisibilityValue`) VALUES
	(270, 9, 1000),
	(6134, 9, 1000),
	(6135, 9, 1000),
	(6342, 8, 1000),
	(6343, 8, 1000),
	(24222, 0, 0),
	(24223, 0, 0),
	(25023, 0, 0),
	(25024, 0, 0),
	(25025, 0, 0),
	(25026, 0, 0),
	(25120, 0, 0),
	(25256, 0, 0),
	(25257, 0, 0),
	(50347, 0, 0),
	(268853, 8, 1000),
	(268854, 5, 1000),
	(2133392, 7, 1000),
	(2133393, 7, 1000),
	(2133394, 7, 1000),
	(2133395, 7, 1000),
	(26628, 0, 0),
	(5141, 0, 0),
	(5193, 0, 0),
	(5205, 0, 0),
	(5382, 0, 0),
	(5398, 0, 0),
	(5405, 0, 0),
	(5425, 0, 0),
	(20458, 0, 0),
	(20459, 0, 0),
	(31619, 0, 0);
/*!40000 ALTER TABLE `gameobject_addon` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
