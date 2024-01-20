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

-- Dumping structure for table acore_world.spell_mixology
DROP TABLE IF EXISTS `spell_mixology`;
CREATE TABLE IF NOT EXISTS `spell_mixology` (
  `entry` int unsigned NOT NULL,
  `pctMod` float NOT NULL DEFAULT '30' COMMENT 'bonus multiplier',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table acore_world.spell_mixology: ~21 rows (approximately)
DELETE FROM `spell_mixology`;
INSERT INTO `spell_mixology` (`entry`, `pctMod`) VALUES
	(28497, 44.4),
	(33721, 40),
	(53746, 44.4),
	(53748, 40),
	(53749, 40),
	(53751, 57),
	(53752, 80),
	(53755, 37.6),
	(53758, 50),
	(53760, 44.4),
	(53763, 35),
	(53764, 33.3),
	(54212, 44.4),
	(60340, 44.4),
	(60341, 44.4),
	(60343, 44.4),
	(60344, 44.4),
	(60345, 44.4),
	(60346, 44.4),
	(60347, 44.4),
	(62380, 80);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
