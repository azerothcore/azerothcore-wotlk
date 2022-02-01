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

-- Дамп структуры для таблица acore_characters.instance_reset
DROP TABLE IF EXISTS `instance_reset`;
CREATE TABLE IF NOT EXISTS `instance_reset` (
  `mapid` SMALLINT unsigned NOT NULL DEFAULT 0,
  `difficulty` TINYINT unsigned NOT NULL DEFAULT 0,
  `resettime` INT unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`mapid`,`difficulty`),
  KEY `difficulty` (`difficulty`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Дамп данных таблицы acore_characters.instance_reset: ~71 rows (приблизительно)
DELETE FROM `instance_reset`;
/*!40000 ALTER TABLE `instance_reset` DISABLE KEYS */;
INSERT INTO `instance_reset` (`mapid`, `difficulty`, `resettime`) VALUES
	(249, 0, 1643270400),
	(249, 1, 1643270400),
	(269, 1, 1642752000),
	(309, 0, 1642752000),
	(409, 0, 1643270400),
	(469, 0, 1643270400),
	(509, 0, 1642752000),
	(531, 0, 1643270400),
	(532, 0, 1643270400),
	(533, 0, 1643270400),
	(533, 1, 1643270400),
	(534, 0, 1643270400),
	(540, 1, 1642752000),
	(542, 1, 1642752000),
	(543, 1, 1642752000),
	(544, 0, 1643270400),
	(545, 1, 1642752000),
	(546, 1, 1642752000),
	(547, 1, 1642752000),
	(548, 0, 1643270400),
	(550, 0, 1643270400),
	(552, 1, 1642752000),
	(553, 1, 1642752000),
	(554, 1, 1642752000),
	(555, 1, 1642752000),
	(556, 1, 1642752000),
	(557, 1, 1642752000),
	(558, 1, 1642752000),
	(560, 1, 1642752000),
	(564, 0, 1643270400),
	(565, 0, 1643270400),
	(568, 0, 1642752000),
	(574, 1, 1642752000),
	(575, 1, 1642752000),
	(576, 1, 1642752000),
	(578, 1, 1642752000),
	(580, 0, 1643270400),
	(585, 1, 1642752000),
	(595, 1, 1642752000),
	(598, 1, 1642752000),
	(599, 1, 1642752000),
	(600, 1, 1642752000),
	(601, 1, 1642752000),
	(602, 1, 1642752000),
	(603, 0, 1643270400),
	(603, 1, 1643270400),
	(604, 1, 1642752000),
	(608, 1, 1642752000),
	(615, 0, 1643270400),
	(615, 1, 1643270400),
	(616, 0, 1643270400),
	(616, 1, 1643270400),
	(619, 1, 1642752000),
	(624, 0, 1643270400),
	(624, 1, 1643270400),
	(631, 0, 1643270400),
	(631, 1, 1643270400),
	(631, 2, 1643270400),
	(631, 3, 1643270400),
	(632, 1, 1642752000),
	(649, 0, 1643270400),
	(649, 1, 1643270400),
	(649, 2, 1643270400),
	(649, 3, 1643270400),
	(650, 1, 1642752000),
	(658, 1, 1642752000),
	(668, 1, 1642752000),
	(724, 0, 1643270400),
	(724, 1, 1643270400),
	(724, 2, 1643270400),
	(724, 3, 1643270400);
/*!40000 ALTER TABLE `instance_reset` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
