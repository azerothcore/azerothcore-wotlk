-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.29 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.0.0.6468
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table acore_characters.log_arena_fights
DROP TABLE IF EXISTS `log_arena_fights`;
CREATE TABLE IF NOT EXISTS `log_arena_fights` (
  `fight_id` int unsigned NOT NULL,
  `time` datetime NOT NULL,
  `type` tinyint unsigned NOT NULL,
  `duration` int unsigned NOT NULL,
  `winner` int unsigned NOT NULL,
  `loser` int unsigned NOT NULL,
  `winner_tr` smallint unsigned NOT NULL,
  `winner_mmr` smallint unsigned NOT NULL,
  `winner_tr_change` smallint NOT NULL,
  `loser_tr` smallint unsigned NOT NULL,
  `loser_mmr` smallint unsigned NOT NULL,
  `loser_tr_change` smallint NOT NULL,
  `currOnline` int unsigned NOT NULL,
  PRIMARY KEY (`fight_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table acore_characters.log_arena_fights: ~0 rows (approximately)
DELETE FROM `log_arena_fights`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
