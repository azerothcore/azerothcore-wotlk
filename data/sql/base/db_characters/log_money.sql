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

-- Дамп структуры для таблица _acore_characters.log_money
DROP TABLE IF EXISTS `log_money`;
CREATE TABLE IF NOT EXISTS `log_money` (
  `sender_acc` INT unsigned NOT NULL,
  `sender_guid` INT unsigned NOT NULL,
  `sender_name` char(32) CHARACTER SET utf8mb4 NOT NULL,
  `sender_ip` char(32) CHARACTER SET utf8mb4 NOT NULL,
  `receiver_acc` INT unsigned NOT NULL,
  `receiver_name` char(32) CHARACTER SET utf8mb4 NOT NULL,
  `money` BIGINT unsigned NOT NULL,
  `topic` char(255) CHARACTER SET utf8mb4 NOT NULL,
  `date` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Дамп данных таблицы _acore_characters.log_money: 0 rows
DELETE FROM `log_money`;
/*!40000 ALTER TABLE `log_money` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_money` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
