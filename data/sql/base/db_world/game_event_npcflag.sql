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

-- Dumpar struktur för tabell acore_world.game_event_npcflag
DROP TABLE IF EXISTS `game_event_npcflag`;
CREATE TABLE IF NOT EXISTS `game_event_npcflag` (
  `eventEntry` tinyint unsigned NOT NULL COMMENT 'Entry of the game event',
  `guid` mediumint unsigned NOT NULL DEFAULT '0',
  `npcflag` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`eventEntry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_world.game_event_npcflag: 5 rows
DELETE FROM `game_event_npcflag`;
/*!40000 ALTER TABLE `game_event_npcflag` DISABLE KEYS */;
INSERT INTO `game_event_npcflag` (`eventEntry`, `guid`, `npcflag`) VALUES
	(17, 1803, 179),
	(17, 26771, 179),
	(17, 38112, 129),
	(17, 46320, 177),
	(17, 208240, 1048705);
/*!40000 ALTER TABLE `game_event_npcflag` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
