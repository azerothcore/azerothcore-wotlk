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

-- Dumping structure for table acore_world.player_race_stats
DROP TABLE IF EXISTS `player_race_stats`;
CREATE TABLE IF NOT EXISTS `player_race_stats` (
  `Race` tinyint unsigned NOT NULL,
  `Strength` int NOT NULL DEFAULT '0',
  `Agility` int NOT NULL DEFAULT '0',
  `Stamina` int NOT NULL DEFAULT '0',
  `Intellect` int NOT NULL DEFAULT '0',
  `Spirit` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`Race`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci PACK_KEYS=0 COMMENT='Stores race stats.';

-- Dumping data for table acore_world.player_race_stats: ~10 rows (approximately)
DELETE FROM `player_race_stats`;
INSERT INTO `player_race_stats` (`Race`, `Strength`, `Agility`, `Stamina`, `Intellect`, `Spirit`) VALUES
	(1, 0, 0, 0, 0, 0),
	(2, 3, -3, 1, -3, 2),
	(3, 5, -4, 1, -1, -1),
	(4, -4, 4, 0, 0, 0),
	(5, -1, -2, 0, -2, 5),
	(6, 5, -4, 1, -4, 2),
	(7, -5, 2, 0, 3, 0),
	(8, 1, 2, 0, -4, 1),
	(10, -3, 2, 0, 3, -2),
	(11, 1, -3, 0, 0, 2);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
