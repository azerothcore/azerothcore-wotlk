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

-- Dumping structure for table acore_characters.worldstates
DROP TABLE IF EXISTS `worldstates`;
CREATE TABLE IF NOT EXISTS `worldstates` (
  `entry` int unsigned NOT NULL DEFAULT '0',
  `value` int unsigned NOT NULL DEFAULT '0',
  `comment` tinytext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Variable Saves';

-- Dumping data for table acore_characters.worldstates: ~105 rows (approximately)
DELETE FROM `worldstates`;
INSERT INTO `worldstates` (`entry`, `value`, `comment`) VALUES
	(1, 0, NULL),
	(2, 0, NULL),
	(3, 0, NULL),
	(4, 0, NULL),
	(5, 0, NULL),
	(6, 0, NULL),
	(7, 0, NULL),
	(8, 0, NULL),
	(9, 0, NULL),
	(10, 0, NULL),
	(11, 0, NULL),
	(12, 0, NULL),
	(13, 0, NULL),
	(14, 0, NULL),
	(15, 0, NULL),
	(16, 0, NULL),
	(17, 0, NULL),
	(18, 0, NULL),
	(19, 0, NULL),
	(20, 0, NULL),
	(21, 0, NULL),
	(22, 0, NULL),
	(23, 0, NULL),
	(24, 0, NULL),
	(25, 0, NULL),
	(26, 0, NULL),
	(27, 0, NULL),
	(28, 0, NULL),
	(29, 0, NULL),
	(30, 0, NULL),
	(31, 0, NULL),
	(32, 0, NULL),
	(33, 0, NULL),
	(34, 0, NULL),
	(35, 0, NULL),
	(36, 0, NULL),
	(37, 0, NULL),
	(38, 0, NULL),
	(39, 0, NULL),
	(40, 0, NULL),
	(41, 0, NULL),
	(42, 0, NULL),
	(43, 0, NULL),
	(44, 0, NULL),
	(45, 0, NULL),
	(46, 0, NULL),
	(47, 0, NULL),
	(48, 0, NULL),
	(49, 0, NULL),
	(50, 0, NULL),
	(51, 0, NULL),
	(52, 0, NULL),
	(53, 0, NULL),
	(54, 0, NULL),
	(55, 0, NULL),
	(56, 0, NULL),
	(57, 0, NULL),
	(58, 0, NULL),
	(59, 0, NULL),
	(60, 0, NULL),
	(61, 0, NULL),
	(62, 0, NULL),
	(63, 0, NULL),
	(64, 0, NULL),
	(65, 0, NULL),
	(66, 0, NULL),
	(67, 0, NULL),
	(68, 0, NULL),
	(69, 0, NULL),
	(70, 0, NULL),
	(71, 0, NULL),
	(72, 0, NULL),
	(73, 0, NULL),
	(74, 0, NULL),
	(75, 0, NULL),
	(76, 0, NULL),
	(77, 0, NULL),
	(78, 0, NULL),
	(79, 0, NULL),
	(80, 0, NULL),
	(81, 0, NULL),
	(82, 0, NULL),
	(83, 0, NULL),
	(84, 0, NULL),
	(85, 0, NULL),
	(86, 0, NULL),
	(87, 0, NULL),
	(88, 0, NULL),
	(89, 0, NULL),
	(90, 0, NULL),
	(197, 0, 'Fishing Extravaganza - STV_FISHING_PREV_WIN_TIME'),
	(198, 0, 'Fishing Extravaganza - STV_FISHING_HAS_WINNER'),
	(199, 0, 'Fishing Extravaganza - STV_FISHING_ANNOUNCE_EVENT_BEGIN'),
	(200, 0, 'Fishing Extravaganza - STV_FISHING_ANNOUNCE_POOLS_DESPAN'),
	(3781, 9000000, NULL),
	(3801, 0, NULL),
	(3802, 1, NULL),
	(20001, 1454691600, 'NextArenaPointDistributionTime'),
	(20002, 1706158800, 'NextWeeklyQuestResetTime'),
	(20003, 1705813200, 'NextBGRandomDailyResetTime'),
	(20004, 0, 'cleaning_flags'),
	(20005, 1705813200, 'NextDailyQuestResetTime'),
	(20006, 1705813200, 'NextGuildDailyResetTime'),
	(20007, 1706763600, 'NextMonthlyQuestResetTime'),
	(20008, 1705813200, NULL);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
