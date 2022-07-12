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
  `pool_id` INT unsigned NOT NULL DEFAULT 0,
  `quest_id` INT unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`pool_id`,`quest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_characters.pool_quest_save: ~38 rows (ungefär)
DELETE FROM `pool_quest_save`;
/*!40000 ALTER TABLE `pool_quest_save` DISABLE KEYS */;
INSERT INTO `pool_quest_save` (`pool_id`, `quest_id`) VALUES
	(348, 24636),
	(349, 14102),
	(350, 13903),
	(351, 13915),
	(352, 11380),
	(353, 11668),
	(354, 13424),
	(356, 11373),
	(357, 11383),
	(358, 14152),
	(359, 14112),
	(360, 14144),
	(361, 14145),
	(362, 12703),
	(363, 14108),
	(380, 12735),
	(381, 12758),
	(382, 12705),
	(384, 13191),
	(385, 13153),
	(386, 12501),
	(5662, 13674),
	(5663, 13764),
	(5664, 13768),
	(5665, 13774),
	(5666, 13779),
	(5667, 13785),
	(5668, 13669),
	(5669, 13616),
	(5670, 13743),
	(5671, 13748),
	(5672, 13757),
	(5673, 13754),
	(5674, 13100),
	(5675, 13115),
	(5676, 13836),
	(5677, 12963),
	(5678, 24584);
/*!40000 ALTER TABLE `pool_quest_save` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
