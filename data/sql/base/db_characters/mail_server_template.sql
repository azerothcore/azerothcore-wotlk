-- --------------------------------------------------------
-- Värd:                         127.0.0.1
-- Serverversion:                8.0.28 - MySQL Community Server - GPL
-- Server-OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumpar struktur för tabell acore_characters.mail_server_template
DROP TABLE IF EXISTS `mail_server_template`;
CREATE TABLE IF NOT EXISTS `mail_server_template` (
  `id` INT unsigned NOT NULL AUTO_INCREMENT,
  `reqLevel` TINYINT unsigned NOT NULL DEFAULT 0,
  `reqPlayTime` INT unsigned NOT NULL DEFAULT 0,
  `moneyA` INT unsigned NOT NULL DEFAULT 0,
  `moneyH` INT unsigned NOT NULL DEFAULT 0,
  `itemA` INT unsigned NOT NULL DEFAULT 0,
  `itemCountA` INT unsigned NOT NULL DEFAULT 0,
  `itemH` INT unsigned NOT NULL DEFAULT 0,
  `itemCountH` INT unsigned NOT NULL DEFAULT 0,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `active` TINYINT unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_characters.mail_server_template: ~0 rows (ungefär)
DELETE FROM `mail_server_template`;
/*!40000 ALTER TABLE `mail_server_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `mail_server_template` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
