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

-- Дамп структуры для таблица _acore_auth.uptime
DROP TABLE IF EXISTS `uptime`;
CREATE TABLE IF NOT EXISTS `uptime` (
  `realmid` INT unsigned NOT NULL,
  `starttime` INT unsigned NOT NULL DEFAULT 0,
  `uptime` INT unsigned NOT NULL DEFAULT 0,
  `maxplayers` SMALLINT unsigned NOT NULL DEFAULT 0,
  `revision` varchar(255) NOT NULL DEFAULT 'AzerothCore',
  PRIMARY KEY (`realmid`,`starttime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Uptime system';

-- Дамп данных таблицы _acore_auth.uptime: ~2 rows (приблизительно)
DELETE FROM `uptime`;
/*!40000 ALTER TABLE `uptime` DISABLE KEYS */;
INSERT INTO `uptime` (`realmid`, `starttime`, `uptime`, `maxplayers`, `revision`) VALUES
	(1, 1550400304, 121, 0, 'AzerothCore rev. 2bcedc2859e7 2019-02-17 10:04:09 +0100 (master branch) (Unix, Debug)'),
	(1, 1550400454, 1440, 0, 'AzerothCore rev. 2bcedc2859e7 2019-02-17 10:04:09 +0100 (master branch) (Unix, Debug)');
/*!40000 ALTER TABLE `uptime` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
