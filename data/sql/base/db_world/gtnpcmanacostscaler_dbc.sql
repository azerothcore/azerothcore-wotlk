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

-- Дамп структуры для таблица _acore_world.gtnpcmanacostscaler_dbc
DROP TABLE IF EXISTS `gtnpcmanacostscaler_dbc`;
CREATE TABLE IF NOT EXISTS `gtnpcmanacostscaler_dbc` (
  `ID` INT NOT NULL DEFAULT 0,
  `Data` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=FIXED;

-- Дамп данных таблицы _acore_world.gtnpcmanacostscaler_dbc: 100 rows
DELETE FROM `gtnpcmanacostscaler_dbc`;
/*!40000 ALTER TABLE `gtnpcmanacostscaler_dbc` DISABLE KEYS */;
INSERT INTO `gtnpcmanacostscaler_dbc` (`ID`, `Data`) VALUES
	(0, 0.193),
	(1, 0.216),
	(2, 0.264),
	(3, 0.31),
	(4, 0.31),
	(5, 0.395),
	(6, 0.436),
	(7, 0.475),
	(8, 0.514),
	(9, 0.552),
	(10, 0.588),
	(11, 0.625),
	(12, 0.661),
	(13, 0.696),
	(14, 0.766),
	(15, 0.8),
	(16, 0.835),
	(17, 0.885),
	(18, 0.919),
	(19, 1),
	(20, 1.034),
	(21, 1.067),
	(22, 1.101),
	(23, 1.165),
	(24, 1.229),
	(25, 1.278),
	(26, 1.328),
	(27, 1.405),
	(28, 1.522),
	(29, 1.612),
	(30, 1.662),
	(31, 1.752),
	(32, 1.805),
	(33, 1.858),
	(34, 1.964),
	(35, 2.032),
	(36, 2.126),
	(37, 2.196),
	(38, 2.292),
	(39, 2.351),
	(40, 2.446),
	(41, 2.506),
	(42, 2.626),
	(43, 2.686),
	(44, 2.782),
	(45, 2.854),
	(46, 2.95),
	(47, 3.012),
	(48, 3.074),
	(49, 3.195),
	(50, 3.269),
	(51, 3.378),
	(52, 3.475),
	(53, 3.583),
	(54, 3.658),
	(55, 3.788),
	(56, 3.863),
	(57, 3.972),
	(58, 4.048),
	(59, 4.167),
	(60, 4.266),
	(61, 4.4),
	(62, 4.514),
	(63, 4.662),
	(64, 4.768),
	(65, 4.908),
	(66, 5.016),
	(67, 5.169),
	(68, 5.292),
	(69, 5.437),
	(70, 5.593),
	(71, 5.709),
	(72, 5.858),
	(73, 5.998),
	(74, 6.15),
	(75, 6.282),
	(76, 6.415),
	(77, 6.594),
	(78, 6.762),
	(79, 6.899),
	(80, 7.082),
	(81, 7.222),
	(82, 7.376),
	(83, 7.552),
	(84, 7.697),
	(85, 7.876),
	(86, 8.024),
	(87, 8.196),
	(88, 8.347),
	(89, 8.533),
	(90, 8.741),
	(91, 8.898),
	(92, 9.055),
	(93, 9.215),
	(94, 9.408),
	(95, 9.572),
	(96, 9.736),
	(97, 9.902),
	(98, 10.091),
	(99, 10.293);
/*!40000 ALTER TABLE `gtnpcmanacostscaler_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
