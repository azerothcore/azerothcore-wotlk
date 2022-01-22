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

-- Дамп структуры для таблица _acore_characters.guild_member_withdraw
DROP TABLE IF EXISTS `guild_member_withdraw`;
CREATE TABLE IF NOT EXISTS `guild_member_withdraw` (
  `guid` INT unsigned NOT NULL,
  `tab0` INT unsigned NOT NULL DEFAULT 0,
  `tab1` INT unsigned NOT NULL DEFAULT 0,
  `tab2` INT unsigned NOT NULL DEFAULT 0,
  `tab3` INT unsigned NOT NULL DEFAULT 0,
  `tab4` INT unsigned NOT NULL DEFAULT 0,
  `tab5` INT unsigned NOT NULL DEFAULT 0,
  `money` INT unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Guild Member Daily Withdraws';

-- Дамп данных таблицы _acore_characters.guild_member_withdraw: ~0 rows (приблизительно)
DELETE FROM `guild_member_withdraw`;
/*!40000 ALTER TABLE `guild_member_withdraw` DISABLE KEYS */;
/*!40000 ALTER TABLE `guild_member_withdraw` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
