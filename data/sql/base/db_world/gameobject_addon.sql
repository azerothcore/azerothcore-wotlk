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

-- Dumping structure for table acore_world.gameobject_addon
DROP TABLE IF EXISTS `gameobject_addon`;
CREATE TABLE IF NOT EXISTS `gameobject_addon` (
  `guid` int unsigned NOT NULL DEFAULT '0',
  `invisibilityType` tinyint unsigned NOT NULL DEFAULT '0',
  `invisibilityValue` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table acore_world.gameobject_addon: ~32 rows (approximately)
DELETE FROM `gameobject_addon`;
INSERT INTO `gameobject_addon` (`guid`, `invisibilityType`, `invisibilityValue`) VALUES
	(270, 9, 1000),
	(5141, 0, 0),
	(5193, 0, 0),
	(5205, 0, 0),
	(5382, 0, 0),
	(5398, 0, 0),
	(5405, 0, 0),
	(5425, 0, 0),
	(6134, 9, 1000),
	(6135, 9, 1000),
	(6342, 8, 1000),
	(6343, 8, 1000),
	(20458, 0, 0),
	(20459, 0, 0),
	(24222, 0, 0),
	(24223, 0, 0),
	(25023, 0, 0),
	(25024, 0, 0),
	(25025, 0, 0),
	(25026, 0, 0),
	(25120, 0, 0),
	(25256, 0, 0),
	(25257, 0, 0),
	(26628, 0, 0),
	(31619, 0, 0),
	(50347, 0, 0),
	(268853, 8, 1000),
	(268854, 5, 1000),
	(2133392, 7, 1000),
	(2133393, 7, 1000),
	(2133394, 7, 1000),
	(2133395, 7, 1000);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
