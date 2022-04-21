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

-- Дамп структуры для таблица acore_world.exploration_basexp
DROP TABLE IF EXISTS `exploration_basexp`;
CREATE TABLE IF NOT EXISTS `exploration_basexp` (
  `level` TINYINT unsigned NOT NULL DEFAULT 0,
  `basexp` MEDIUMINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`level`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=FIXED COMMENT='Exploration System';

-- Дамп данных таблицы acore_world.exploration_basexp: 80 rows
DELETE FROM `exploration_basexp`;
/*!40000 ALTER TABLE `exploration_basexp` DISABLE KEYS */;
INSERT INTO `exploration_basexp` (`level`, `basexp`) VALUES
	(0, 0),
	(1, 5),
	(2, 15),
	(3, 25),
	(4, 35),
	(5, 45),
	(6, 55),
	(7, 65),
	(8, 70),
	(9, 80),
	(10, 85),
	(11, 90),
	(12, 90),
	(13, 90),
	(14, 100),
	(15, 105),
	(16, 115),
	(17, 125),
	(18, 135),
	(19, 145),
	(20, 155),
	(21, 165),
	(22, 175),
	(23, 185),
	(24, 195),
	(25, 200),
	(26, 210),
	(27, 220),
	(28, 230),
	(29, 240),
	(30, 245),
	(31, 250),
	(32, 255),
	(33, 265),
	(34, 270),
	(35, 275),
	(36, 280),
	(37, 285),
	(38, 285),
	(39, 300),
	(40, 315),
	(41, 330),
	(42, 345),
	(43, 360),
	(44, 375),
	(45, 390),
	(46, 405),
	(47, 420),
	(48, 440),
	(49, 455),
	(50, 470),
	(51, 490),
	(52, 510),
	(53, 530),
	(54, 540),
	(55, 560),
	(56, 580),
	(57, 600),
	(58, 620),
	(59, 640),
	(60, 660),
	(61, 970),
	(62, 1000),
	(63, 1050),
	(64, 1080),
	(65, 1100),
	(66, 1130),
	(67, 1160),
	(68, 1200),
	(69, 1230),
	(70, 1300),
	(71, 1330),
	(72, 1370),
	(73, 1410),
	(74, 1440),
	(75, 1470),
	(76, 1510),
	(77, 1530),
	(78, 1600),
	(79, 1630);
/*!40000 ALTER TABLE `exploration_basexp` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
