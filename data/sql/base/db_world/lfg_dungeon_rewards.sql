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

-- Dumping structure for table acore_world.lfg_dungeon_rewards
DROP TABLE IF EXISTS `lfg_dungeon_rewards`;
CREATE TABLE IF NOT EXISTS `lfg_dungeon_rewards` (
  `dungeonId` int unsigned NOT NULL DEFAULT '0' COMMENT 'Dungeon entry from dbc',
  `maxLevel` tinyint unsigned NOT NULL DEFAULT '0' COMMENT 'Max level at which this reward is rewarded',
  `firstQuestId` int unsigned NOT NULL DEFAULT '0' COMMENT 'Quest id with rewards for first dungeon this day',
  `otherQuestId` int unsigned NOT NULL DEFAULT '0' COMMENT 'Quest id with rewards for Nth dungeon this day',
  PRIMARY KEY (`dungeonId`,`maxLevel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table acore_world.lfg_dungeon_rewards: ~15 rows (approximately)
DELETE FROM `lfg_dungeon_rewards`;
INSERT INTO `lfg_dungeon_rewards` (`dungeonId`, `maxLevel`, `firstQuestId`, `otherQuestId`) VALUES
	(258, 15, 24881, 24889),
	(258, 25, 24882, 24890),
	(258, 34, 24883, 24891),
	(258, 45, 24884, 24892),
	(258, 55, 24885, 24893),
	(258, 60, 24886, 24894),
	(259, 64, 24887, 24895),
	(259, 70, 24888, 24896),
	(260, 70, 24922, 24923),
	(261, 80, 24790, 24791),
	(262, 80, 24788, 24789),
	(285, 80, 25482, 0),
	(286, 80, 25484, 0),
	(287, 80, 25483, 0),
	(288, 80, 25485, 0);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
