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

-- Dumpar struktur för tabell acore_characters.worldstates
DROP TABLE IF EXISTS `worldstates`;
CREATE TABLE IF NOT EXISTS `worldstates` (
  `entry` INT unsigned NOT NULL DEFAULT 0,
  `value` INT unsigned NOT NULL DEFAULT 0,
  `comment` tinytext,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Variable Saves';

-- Dumpar data för tabell acore_characters.worldstates: ~93 rows (ungefär)
DELETE FROM `worldstates`;
/*!40000 ALTER TABLE `worldstates` DISABLE KEYS */;
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
	(16, 0, NULL),
	(17, 0, NULL),
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
	(31, 0, NULL),
	(32, 0, NULL),
	(33, 0, NULL),
	(34, 0, NULL),
	(35, 0, NULL),
	(36, 0, NULL),
	(37, 0, NULL),
	(38, 0, NULL),
	(39, 0, NULL),
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
	(3781, 9000000, NULL),
	(3801, 0, NULL),
	(3802, 1, NULL),
	(20001, 1454691600, 'NextArenaPointDistributionTime'),
	(20002, 1651118400, 'NextWeeklyQuestResetTime'),
	(20003, 1650859200, 'NextBGRandomDailyResetTime'),
	(20004, 0, 'cleaning_flags'),
	(20005, 1650859200, 'NextDailyQuestResetTime'),
	(20006, 1650859200, 'NextGuildDailyResetTime'),
	(20007, 1651377600, 'NextMonthlyQuestResetTime'),
	(20008, 1650859200, NULL);
/*!40000 ALTER TABLE `worldstates` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
