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

-- Dumpar struktur för tabell acore_world.player_factionchange_reputations
DROP TABLE IF EXISTS `player_factionchange_reputations`;
CREATE TABLE IF NOT EXISTS `player_factionchange_reputations` (
  `alliance_id` INT unsigned NOT NULL,
  `horde_id` INT unsigned NOT NULL,
  PRIMARY KEY (`alliance_id`,`horde_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_world.player_factionchange_reputations: 15 rows
DELETE FROM `player_factionchange_reputations`;
/*!40000 ALTER TABLE `player_factionchange_reputations` DISABLE KEYS */;
INSERT INTO `player_factionchange_reputations` (`alliance_id`, `horde_id`) VALUES
	(47, 530),
	(54, 81),
	(69, 68),
	(72, 76),
	(509, 510),
	(730, 729),
	(890, 889),
	(930, 911),
	(946, 947),
	(978, 941),
	(1037, 1052),
	(1050, 1085),
	(1068, 1064),
	(1094, 1124),
	(1126, 1067);
/*!40000 ALTER TABLE `player_factionchange_reputations` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
