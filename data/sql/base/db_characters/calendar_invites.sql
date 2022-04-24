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

-- Dumpar struktur för tabell acore_characters.calendar_invites
DROP TABLE IF EXISTS `calendar_invites`;
CREATE TABLE IF NOT EXISTS `calendar_invites` (
  `id` BIGINT unsigned NOT NULL DEFAULT 0,
  `event` BIGINT unsigned NOT NULL DEFAULT 0,
  `invitee` INT unsigned NOT NULL DEFAULT 0,
  `sender` INT unsigned NOT NULL DEFAULT 0,
  `status` TINYINT unsigned NOT NULL DEFAULT 0,
  `statustime` INT unsigned NOT NULL DEFAULT 0,
  `rank` TINYINT unsigned NOT NULL DEFAULT 0,
  `text` VARCHAR(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_characters.calendar_invites: ~0 rows (ungefär)
DELETE FROM `calendar_invites`;
/*!40000 ALTER TABLE `calendar_invites` DISABLE KEYS */;
/*!40000 ALTER TABLE `calendar_invites` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
