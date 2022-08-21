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

-- Dumpar struktur för tabell acore_characters.pool_quest_save
DROP TABLE IF EXISTS `pool_quest_save`;
CREATE TABLE IF NOT EXISTS `pool_quest_save` (
  `pool_id` int unsigned NOT NULL DEFAULT '0',
  `quest_id` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`pool_id`,`quest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_characters.pool_quest_save: ~38 rows (ungefär)
DELETE FROM `pool_quest_save`;
/*!40000 ALTER TABLE `pool_quest_save` DISABLE KEYS */;
INSERT INTO `pool_quest_save` (`pool_id`, `quest_id`) VALUES
	(348, 24629),
	(349, 14101),
	(350, 13889),
	(351, 13917),
	(352, 11377),
	(353, 11666),
	(354, 13423),
	(356, 11363),
	(357, 11385),
	(358, 14074),
	(359, 14076),
	(360, 14140),
	(361, 14141),
	(362, 12760),
	(363, 14107),
	(380, 12737),
	(381, 12741),
	(382, 12762),
	(384, 13192),
	(385, 236),
	(386, 12587),
	(5662, 13673),
	(5663, 13762),
	(5664, 13770),
	(5665, 13773),
	(5666, 13778),
	(5667, 13784),
	(5668, 13666),
	(5669, 13603),
	(5670, 13742),
	(5671, 13746),
	(5672, 13759),
	(5673, 13752),
	(5674, 13101),
	(5675, 13116),
	(5676, 13833),
	(5677, 12959),
	(5678, 24585);
/*!40000 ALTER TABLE `pool_quest_save` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
