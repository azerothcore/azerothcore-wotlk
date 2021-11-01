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

-- Дамп структуры для таблица _acore_auth.logs_ip_actions
DROP TABLE IF EXISTS `logs_ip_actions`;
CREATE TABLE IF NOT EXISTS `logs_ip_actions` (
  `id` INT unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique Identifier',
  `account_id` INT unsigned NOT NULL COMMENT 'Account ID',
  `character_guid` INT unsigned NOT NULL COMMENT 'Character Guid',
  `type` TINYINT unsigned NOT NULL,
  `ip` varchar(15) NOT NULL DEFAULT '127.0.0.1',
  `systemnote` text DEFAULT NULL COMMENT 'Notes inserted by system',
  `unixtime` INT unsigned NOT NULL COMMENT 'Unixtime',
  `time` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Timestamp',
  `comment` text DEFAULT NULL COMMENT 'Allows users to add a comment',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Used to log ips of individual actions';

-- Дамп данных таблицы _acore_auth.logs_ip_actions: ~0 rows (приблизительно)
DELETE FROM `logs_ip_actions`;
/*!40000 ALTER TABLE `logs_ip_actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs_ip_actions` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
