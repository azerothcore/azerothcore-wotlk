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

-- Dumping structure for table acore_world.lfg_dungeon_template
DROP TABLE IF EXISTS `lfg_dungeon_template`;
CREATE TABLE IF NOT EXISTS `lfg_dungeon_template` (
  `dungeonId` int unsigned NOT NULL DEFAULT '0' COMMENT 'Unique id from LFGDungeons.dbc',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`dungeonId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table acore_world.lfg_dungeon_template: ~22 rows (approximately)
DELETE FROM `lfg_dungeon_template`;
INSERT INTO `lfg_dungeon_template` (`dungeonId`, `name`, `position_x`, `position_y`, `position_z`, `orientation`, `VerifiedBuild`) VALUES
	(2, 'Scholomance', 196.37, 127.05, 134.91, 6.09, 0),
	(14, 'Gnomeregan', -332.22, -2.28, -150.86, 2.77, 0),
	(18, 'Scarlet Monastery - Graveyard', 1688.99, 1053.48, 18.6775, 0.00117, 0),
	(22, 'Uldaman', -226.8, 49.09, -46.03, 1.39, 0),
	(26, 'Maraudon - Orange Crystals', 1019.69, -458.31, -43.43, 0.31, 0),
	(30, 'Blackrock Depths - Prison', 458.32, 26.52, -70.67, 4.95, 0),
	(32, 'Lower Blackrock Spire', 78.5083, -225.044, 49.839, 5.1, 0),
	(34, 'Dire Maul - East', 44.4499, -154.822, -2.71201, 0, 0),
	(36, 'Dire Maul - West', -62.9658, 159.867, -3.46206, 3.14788, 0),
	(38, 'Dire Maul - North', 255.249, -16.0561, -2.58737, 4.7, 0),
	(40, 'Stratholme - Main Gate', 3395.09, -3380.25, 142.702, 0.1, 0),
	(163, 'Scarlet Monastery - Armory', 1610.83, -323.433, 18.6738, 6.28022, 0),
	(164, 'Scarlet Monastery - Cathedral', 855.683, 1321.5, 18.6709, 0.001747, 0),
	(165, 'Scarlet Monastery - Library', 255.346, -209.09, 18.6773, 6.26656, 0),
	(272, 'Maraudon - Purple Crystals', 752.91, -616.53, -33.11, 1.37, 0),
	(273, 'Maraudon - Pristine Waters', 495.702, 17.3372, -96.3128, 3.11854, 0),
	(274, 'Stratholme - Service Entrance', 3593.15, -3646.56, 138.5, 5.33, 0),
	(276, 'Blackrock Depths - Upper City', 458.32, 26.52, -70.67, 4.95, 0),
	(285, 'The Headless Horseman', 1797.52, 1347.38, 18.8876, 3.142, 0),
	(286, 'The Frost Lord Ahune', -100.396, -95.9996, -4.28423, 4.71239, 0),
	(287, 'Coren Direbrew', 897.495, -141.976, -49.7563, 2.1255, 0),
	(288, 'The Crown Chemical Co.', -238.075, 2166.43, 88.853, 1.13446, 0);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
