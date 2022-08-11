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

-- Dumpar struktur för tabell acore_world.game_event_arena_seasons
DROP TABLE IF EXISTS `game_event_arena_seasons`;
CREATE TABLE IF NOT EXISTS `game_event_arena_seasons` (
  `eventEntry` TINYINT unsigned NOT NULL COMMENT 'Entry of the game event',
  `season` TINYINT unsigned NOT NULL COMMENT 'Arena season number',
  UNIQUE KEY `season` (`season`,`eventEntry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_world.game_event_arena_seasons: 6 rows
DELETE FROM `game_event_arena_seasons`;
/*!40000 ALTER TABLE `game_event_arena_seasons` DISABLE KEYS */;
INSERT INTO `game_event_arena_seasons` (`eventEntry`, `season`) VALUES
	(55, 3),
	(56, 4),
	(57, 5),
	(58, 6),
	(59, 7),
	(60, 8);
/*!40000 ALTER TABLE `game_event_arena_seasons` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
