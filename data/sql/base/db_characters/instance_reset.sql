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

-- Dumpar struktur för tabell acore_characters.instance_reset
DROP TABLE IF EXISTS `instance_reset`;
CREATE TABLE IF NOT EXISTS `instance_reset` (
  `mapid` smallint unsigned NOT NULL DEFAULT '0',
  `difficulty` tinyint unsigned NOT NULL DEFAULT '0',
  `resettime` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`mapid`,`difficulty`),
  KEY `difficulty` (`difficulty`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_characters.instance_reset: ~71 rows (ungefär)
DELETE FROM `instance_reset`;
/*!40000 ALTER TABLE `instance_reset` DISABLE KEYS */;
INSERT INTO `instance_reset` (`mapid`, `difficulty`, `resettime`) VALUES
	(249, 0, 1661443200),
	(249, 1, 1661443200),
	(269, 1, 1661068800),
	(309, 0, 1661155200),
	(409, 0, 1661443200),
	(469, 0, 1661443200),
	(509, 0, 1661155200),
	(531, 0, 1661443200),
	(532, 0, 1661443200),
	(533, 0, 1661443200),
	(533, 1, 1661443200),
	(534, 0, 1661443200),
	(540, 1, 1661068800),
	(542, 1, 1661068800),
	(543, 1, 1661068800),
	(544, 0, 1661443200),
	(545, 1, 1661068800),
	(546, 1, 1661068800),
	(547, 1, 1661068800),
	(548, 0, 1661443200),
	(550, 0, 1661443200),
	(552, 1, 1661068800),
	(553, 1, 1661068800),
	(554, 1, 1661068800),
	(555, 1, 1661068800),
	(556, 1, 1661068800),
	(557, 1, 1661068800),
	(558, 1, 1661068800),
	(560, 1, 1661068800),
	(564, 0, 1661443200),
	(565, 0, 1661443200),
	(568, 0, 1661155200),
	(574, 1, 1661068800),
	(575, 1, 1661068800),
	(576, 1, 1661068800),
	(578, 1, 1661097600),
	(580, 0, 1661443200),
	(585, 1, 1661097600),
	(595, 1, 1661097600),
	(598, 1, 1661097600),
	(599, 1, 1661097600),
	(600, 1, 1661097600),
	(601, 1, 1661097600),
	(602, 1, 1661097600),
	(603, 0, 1661443200),
	(603, 1, 1661443200),
	(604, 1, 1661097600),
	(608, 1, 1661097600),
	(615, 0, 1661443200),
	(615, 1, 1661443200),
	(616, 0, 1661443200),
	(616, 1, 1661443200),
	(619, 1, 1661097600),
	(624, 0, 1661443200),
	(624, 1, 1661443200),
	(631, 0, 1661443200),
	(631, 1, 1661443200),
	(631, 2, 1661443200),
	(631, 3, 1661443200),
	(632, 1, 1661097600),
	(649, 0, 1661443200),
	(649, 1, 1661443200),
	(649, 2, 1661443200),
	(649, 3, 1661443200),
	(650, 1, 1661097600),
	(658, 1, 1661097600),
	(668, 1, 1661097600),
	(724, 0, 1661443200),
	(724, 1, 1661443200),
	(724, 2, 1661443200),
	(724, 3, 1661443200);
/*!40000 ALTER TABLE `instance_reset` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
