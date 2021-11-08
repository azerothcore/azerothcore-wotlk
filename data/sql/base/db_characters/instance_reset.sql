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

-- Дамп структуры для таблица _acore_characters.instance_reset
DROP TABLE IF EXISTS `instance_reset`;
CREATE TABLE IF NOT EXISTS `instance_reset` (
  `mapid` SMALLINT unsigned NOT NULL DEFAULT 0,
  `difficulty` TINYINT unsigned NOT NULL DEFAULT 0,
  `resettime` INT unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`mapid`,`difficulty`),
  KEY `difficulty` (`difficulty`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Дамп данных таблицы _acore_characters.instance_reset: ~71 rows (приблизительно)
DELETE FROM `instance_reset`;
/*!40000 ALTER TABLE `instance_reset` DISABLE KEYS */;
INSERT INTO `instance_reset` (`mapid`, `difficulty`, `resettime`) VALUES
	(249, 0, 1634788800),
	(249, 1, 1634788800),
	(269, 1, 1634270400),
	(309, 0, 1634443200),
	(409, 0, 1634788800),
	(469, 0, 1634788800),
	(509, 0, 1634443200),
	(531, 0, 1634788800),
	(532, 0, 1634788800),
	(533, 0, 1634788800),
	(533, 1, 1634788800),
	(534, 0, 1634788800),
	(540, 1, 1634270400),
	(542, 1, 1634270400),
	(543, 1, 1634270400),
	(544, 0, 1634788800),
	(545, 1, 1634270400),
	(546, 1, 1634270400),
	(547, 1, 1634270400),
	(548, 0, 1634788800),
	(550, 0, 1634788800),
	(552, 1, 1634270400),
	(553, 1, 1634270400),
	(554, 1, 1634270400),
	(555, 1, 1634270400),
	(556, 1, 1634270400),
	(557, 1, 1634270400),
	(558, 1, 1634270400),
	(560, 1, 1634270400),
	(564, 0, 1634788800),
	(565, 0, 1634788800),
	(568, 0, 1634443200),
	(574, 1, 1634270400),
	(575, 1, 1634270400),
	(576, 1, 1634270400),
	(578, 1, 1634270400),
	(580, 0, 1634788800),
	(585, 1, 1634270400),
	(595, 1, 1634270400),
	(598, 1, 1634270400),
	(599, 1, 1634270400),
	(600, 1, 1634270400),
	(601, 1, 1634270400),
	(602, 1, 1634270400),
	(603, 0, 1634788800),
	(603, 1, 1634788800),
	(604, 1, 1634270400),
	(608, 1, 1634270400),
	(615, 0, 1634788800),
	(615, 1, 1634788800),
	(616, 0, 1634788800),
	(616, 1, 1634788800),
	(619, 1, 1634270400),
	(624, 0, 1634788800),
	(624, 1, 1634788800),
	(631, 0, 1634788800),
	(631, 1, 1634788800),
	(631, 2, 1634788800),
	(631, 3, 1634788800),
	(632, 1, 1634270400),
	(649, 0, 1634788800),
	(649, 1, 1634788800),
	(649, 2, 1634788800),
	(649, 3, 1634788800),
	(650, 1, 1634270400),
	(658, 1, 1634270400),
	(668, 1, 1634270400),
	(724, 0, 1634788800),
	(724, 1, 1634788800),
	(724, 2, 1634788800),
	(724, 3, 1634788800);
/*!40000 ALTER TABLE `instance_reset` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
