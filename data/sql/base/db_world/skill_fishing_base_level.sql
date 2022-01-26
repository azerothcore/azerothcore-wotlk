-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               10.6.4-MariaDB - mariadb.org binary distribution
-- Операционная система:         Win64
-- HeidiSQL Версия:              11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Дамп структуры для таблица acore_world.skill_fishing_base_level
DROP TABLE IF EXISTS `skill_fishing_base_level`;
CREATE TABLE IF NOT EXISTS `skill_fishing_base_level` (
  `entry` MEDIUMINT unsigned NOT NULL DEFAULT 0 COMMENT 'Area identifier',
  `skill` SMALLINT NOT NULL DEFAULT 0 COMMENT 'Base skill level requirement',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=FIXED COMMENT='Fishing system';

-- Дамп данных таблицы acore_world.skill_fishing_base_level: 94 rows
DELETE FROM `skill_fishing_base_level`;
/*!40000 ALTER TABLE `skill_fishing_base_level` DISABLE KEYS */;
INSERT INTO `skill_fishing_base_level` (`entry`, `skill`) VALUES
	(1, -70),
	(8, 130),
	(10, 55),
	(11, 55),
	(12, -70),
	(14, -70),
	(15, 130),
	(16, 205),
	(17, -20),
	(28, 205),
	(33, 130),
	(36, 130),
	(38, -20),
	(40, -20),
	(41, 330),
	(44, 55),
	(45, 130),
	(46, 330),
	(47, 205),
	(65, 380),
	(85, -70),
	(130, -20),
	(139, 330),
	(141, -70),
	(148, -20),
	(215, -70),
	(267, 55),
	(297, 205),
	(331, 55),
	(357, 205),
	(361, 205),
	(394, 380),
	(400, 130),
	(405, 130),
	(406, 55),
	(440, 205),
	(490, 205),
	(493, 205),
	(495, 380),
	(618, 330),
	(718, -20),
	(719, -20),
	(796, 130),
	(1112, 330),
	(1222, 330),
	(1227, 330),
	(1377, 330),
	(1417, 205),
	(1497, -20),
	(1519, -20),
	(1537, -20),
	(1581, -20),
	(1637, -20),
	(1638, -20),
	(1657, -20),
	(1977, 330),
	(2017, 330),
	(2057, 330),
	(2100, 205),
	(2817, 405),
	(3140, 330),
	(3430, -70),
	(3433, -20),
	(3479, 225),
	(3483, 280),
	(3518, 380),
	(3519, 355),
	(3520, 280),
	(3521, 305),
	(3523, 380),
	(3524, -70),
	(3525, -20),
	(3537, 380),
	(3607, 300),
	(3614, 395),
	(3621, 395),
	(3625, 280),
	(3653, 355),
	(3656, 355),
	(3658, 355),
	(3690, 405),
	(3691, 405),
	(3692, 405),
	(3711, 430),
	(3805, 330),
	(3859, 405),
	(3979, 480),
	(4080, 355),
	(4197, 430),
	(4395, 430),
	(4656, 430),
	(4710, 480),
	(4722, 430),
	(4813, 450);
/*!40000 ALTER TABLE `skill_fishing_base_level` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
