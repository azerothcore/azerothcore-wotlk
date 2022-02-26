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

-- Дамп структуры для таблица acore_world.gtbarbershopcostbase_dbc
DROP TABLE IF EXISTS `gtbarbershopcostbase_dbc`;
CREATE TABLE IF NOT EXISTS `gtbarbershopcostbase_dbc` (
  `ID` INT NOT NULL DEFAULT 0,
  `Data` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=FIXED;

-- Дамп данных таблицы acore_world.gtbarbershopcostbase_dbc: 100 rows
DELETE FROM `gtbarbershopcostbase_dbc`;
/*!40000 ALTER TABLE `gtbarbershopcostbase_dbc` DISABLE KEYS */;
INSERT INTO `gtbarbershopcostbase_dbc` (`ID`, `Data`) VALUES
	(0, 0),
	(1, 3),
	(2, 4),
	(3, 4),
	(4, 4),
	(5, 6),
	(6, 12),
	(7, 23),
	(8, 40),
	(9, 65),
	(10, 100),
	(11, 146),
	(12, 204),
	(13, 276),
	(14, 364),
	(15, 469),
	(16, 592),
	(17, 735),
	(18, 900),
	(19, 1088),
	(20, 1300),
	(21, 1538),
	(22, 1804),
	(23, 2099),
	(24, 2424),
	(25, 2781),
	(26, 3172),
	(27, 3598),
	(28, 4060),
	(29, 4560),
	(30, 5100),
	(31, 5681),
	(32, 6304),
	(33, 6971),
	(34, 7684),
	(35, 8444),
	(36, 9252),
	(37, 10110),
	(38, 11020),
	(39, 11983),
	(40, 13000),
	(41, 14073),
	(42, 15204),
	(43, 16394),
	(44, 17644),
	(45, 18956),
	(46, 20332),
	(47, 21773),
	(48, 23280),
	(49, 24855),
	(50, 26500),
	(51, 28216),
	(52, 30004),
	(53, 31866),
	(54, 33804),
	(55, 35819),
	(56, 37912),
	(57, 40085),
	(58, 42340),
	(59, 44678),
	(60, 47100),
	(61, 49608),
	(62, 52204),
	(63, 54889),
	(64, 57664),
	(65, 60531),
	(66, 63492),
	(67, 66548),
	(68, 69700),
	(69, 72950),
	(70, 76300),
	(71, 79751),
	(72, 83304),
	(73, 86961),
	(74, 90724),
	(75, 94594),
	(76, 98572),
	(77, 102660),
	(78, 106860),
	(79, 111173),
	(80, 115600),
	(81, 120143),
	(82, 124804),
	(83, 129584),
	(84, 134484),
	(85, 139506),
	(86, 144652),
	(87, 149923),
	(88, 155320),
	(89, 160845),
	(90, 166500),
	(91, 172286),
	(92, 178204),
	(93, 184256),
	(94, 190444),
	(95, 196769),
	(96, 203232),
	(97, 209835),
	(98, 216580),
	(99, 223468);
/*!40000 ALTER TABLE `gtbarbershopcostbase_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
