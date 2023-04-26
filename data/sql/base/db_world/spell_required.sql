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

-- Dumping structure for table acore_world.spell_required
DROP TABLE IF EXISTS `spell_required`;
CREATE TABLE IF NOT EXISTS `spell_required` (
  `spell_id` int NOT NULL DEFAULT '0',
  `req_spell` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`spell_id`,`req_spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Spell Additinal Data';

-- Dumping data for table acore_world.spell_required: ~50 rows (approximately)
DELETE FROM `spell_required`;
INSERT INTO `spell_required` (`spell_id`, `req_spell`) VALUES
	(99, 5487),
	(779, 5487),
	(1079, 768),
	(1082, 768),
	(1822, 768),
	(1850, 768),
	(5209, 5487),
	(5211, 5487),
	(5215, 768),
	(5217, 768),
	(5221, 768),
	(5225, 768),
	(5229, 5487),
	(6785, 768),
	(8998, 768),
	(9005, 768),
	(16689, 339),
	(16810, 1062),
	(16811, 5195),
	(16812, 5196),
	(16813, 9852),
	(17329, 9853),
	(20719, 768),
	(22568, 768),
	(22570, 768),
	(22842, 5487),
	(23161, 5784),
	(23161, 33391),
	(23214, 13819),
	(23214, 33391),
	(25782, 19838),
	(25894, 19854),
	(25899, 20911),
	(25916, 25291),
	(25918, 25290),
	(27009, 26989),
	(27141, 27140),
	(27143, 27142),
	(27681, 14752),
	(33745, 5487),
	(34767, 33391),
	(34767, 34769),
	(48933, 48931),
	(48934, 48932),
	(48937, 48935),
	(48938, 48936),
	(52610, 768),
	(53312, 53308),
	(62078, 768),
	(62600, 5487);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
