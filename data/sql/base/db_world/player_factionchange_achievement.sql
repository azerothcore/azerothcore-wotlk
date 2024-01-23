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

-- Dumping structure for table acore_world.player_factionchange_achievement
DROP TABLE IF EXISTS `player_factionchange_achievement`;
CREATE TABLE IF NOT EXISTS `player_factionchange_achievement` (
  `alliance_id` int unsigned NOT NULL,
  `horde_id` int unsigned NOT NULL,
  PRIMARY KEY (`alliance_id`,`horde_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table acore_world.player_factionchange_achievement: ~124 rows (approximately)
DELETE FROM `player_factionchange_achievement`;
INSERT INTO `player_factionchange_achievement` (`alliance_id`, `horde_id`) VALUES
	(33, 1358),
	(34, 1356),
	(35, 1359),
	(37, 1357),
	(41, 1360),
	(58, 593),
	(202, 1502),
	(203, 1251),
	(206, 1252),
	(220, 873),
	(225, 1164),
	(230, 1175),
	(246, 1005),
	(388, 1006),
	(433, 443),
	(434, 445),
	(435, 444),
	(436, 447),
	(437, 448),
	(438, 469),
	(439, 451),
	(440, 452),
	(441, 450),
	(442, 454),
	(470, 468),
	(471, 453),
	(472, 449),
	(473, 446),
	(604, 603),
	(610, 615),
	(611, 616),
	(612, 617),
	(613, 618),
	(614, 619),
	(701, 700),
	(707, 706),
	(709, 708),
	(711, 710),
	(713, 712),
	(764, 763),
	(899, 901),
	(907, 714),
	(908, 909),
	(942, 943),
	(948, 762),
	(963, 965),
	(966, 967),
	(969, 968),
	(970, 971),
	(1012, 1011),
	(1022, 1025),
	(1023, 1026),
	(1024, 1027),
	(1028, 1031),
	(1029, 1032),
	(1030, 1033),
	(1034, 1036),
	(1035, 1037),
	(1038, 1039),
	(1040, 1041),
	(1151, 224),
	(1167, 1168),
	(1169, 1170),
	(1172, 1173),
	(1184, 1203),
	(1189, 1271),
	(1191, 1272),
	(1192, 1273),
	(1255, 259),
	(1262, 1274),
	(1279, 1280),
	(1466, 926),
	(1563, 1784),
	(1656, 1657),
	(1676, 1677),
	(1678, 1680),
	(1681, 1682),
	(1684, 1683),
	(1686, 1685),
	(1692, 1691),
	(1697, 1698),
	(1707, 1693),
	(1737, 2476),
	(1752, 2776),
	(1757, 2200),
	(1762, 2192),
	(1782, 1783),
	(2016, 2017),
	(2144, 2145),
	(2194, 2195),
	(2419, 2497),
	(2421, 2420),
	(2536, 2537),
	(2760, 2768),
	(2761, 2767),
	(2762, 2766),
	(2763, 2769),
	(2764, 2765),
	(2770, 2771),
	(2777, 2786),
	(2778, 2785),
	(2779, 2784),
	(2780, 2787),
	(2781, 2783),
	(2782, 2788),
	(2797, 2798),
	(2817, 2816),
	(3356, 3357),
	(3478, 3656),
	(3556, 3557),
	(3576, 3577),
	(3580, 3581),
	(3596, 3597),
	(3676, 3677),
	(3846, 4176),
	(3851, 4177),
	(3856, 4256),
	(3857, 3957),
	(4156, 4079),
	(4296, 3778),
	(4298, 4297),
	(4436, 4437),
	(4784, 4785),
	(4786, 4790);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
