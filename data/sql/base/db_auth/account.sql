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

-- Dumpar struktur för tabell acore_auth.account
DROP TABLE IF EXISTS `account`;
CREATE TABLE IF NOT EXISTS `account` (
  `id` INT unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identifier',
  `username` VARCHAR(32) NOT NULL DEFAULT '',
  `salt` binary(32) NOT NULL,
  `verifier` binary(32) NOT NULL,
  `session_key` binary(40) DEFAULT NULL,
  `totp_secret` varbinary(128) DEFAULT NULL,
  `email` VARCHAR(255) NOT NULL DEFAULT '',
  `reg_mail` VARCHAR(255) NOT NULL DEFAULT '',
  `joindate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_ip` VARCHAR(15) NOT NULL DEFAULT '127.0.0.1',
  `last_attempt_ip` VARCHAR(15) NOT NULL DEFAULT '127.0.0.1',
  `failed_logins` INT unsigned NOT NULL DEFAULT 0,
  `locked` TINYINT unsigned NOT NULL DEFAULT 0,
  `lock_country` VARCHAR(2) NOT NULL DEFAULT '00',
  `last_login` timestamp NULL DEFAULT NULL,
  `online` INT unsigned NOT NULL DEFAULT 0,
  `expansion` TINYINT unsigned NOT NULL DEFAULT '2',
  `mutetime` BIGINT NOT NULL DEFAULT 0,
  `mutereason` VARCHAR(255) NOT NULL DEFAULT '',
  `muteby` VARCHAR(50) NOT NULL DEFAULT '',
  `locale` TINYINT unsigned NOT NULL DEFAULT 0,
  `os` VARCHAR(3) NOT NULL DEFAULT '',
  `recruiter` INT unsigned NOT NULL DEFAULT 0,
  `totaltime` INT unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Account System';

-- Dumpar data för tabell acore_auth.account: ~0 rows (ungefär)
DELETE FROM `account`;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
/*!40000 ALTER TABLE `account` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
