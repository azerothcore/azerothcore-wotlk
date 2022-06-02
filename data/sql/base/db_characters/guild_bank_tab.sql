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

-- Dumpar struktur för tabell acore_characters.guild_bank_tab
DROP TABLE IF EXISTS `guild_bank_tab`;
CREATE TABLE IF NOT EXISTS `guild_bank_tab` (
  `guildid` INT unsigned NOT NULL DEFAULT 0,
  `TabId` TINYINT unsigned NOT NULL DEFAULT 0,
  `TabName` VARCHAR(16) NOT NULL DEFAULT '',
  `TabIcon` VARCHAR(100) NOT NULL DEFAULT '',
  `TabText` VARCHAR(500) DEFAULT NULL,
  PRIMARY KEY (`guildid`,`TabId`),
  KEY `guildid_key` (`guildid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_characters.guild_bank_tab: ~0 rows (ungefär)
DELETE FROM `guild_bank_tab`;
/*!40000 ALTER TABLE `guild_bank_tab` DISABLE KEYS */;
/*!40000 ALTER TABLE `guild_bank_tab` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
