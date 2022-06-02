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

-- Dumpar struktur för tabell acore_characters.item_instance
DROP TABLE IF EXISTS `item_instance`;
CREATE TABLE IF NOT EXISTS `item_instance` (
  `guid` INT unsigned NOT NULL DEFAULT 0,
  `itemEntry` MEDIUMINT unsigned NOT NULL DEFAULT 0,
  `owner_guid` INT unsigned NOT NULL DEFAULT 0,
  `creatorGuid` INT unsigned NOT NULL DEFAULT 0,
  `giftCreatorGuid` INT unsigned NOT NULL DEFAULT 0,
  `count` INT unsigned NOT NULL DEFAULT 1,
  `duration` INT NOT NULL DEFAULT 0,
  `charges` tinytext,
  `flags` MEDIUMINT unsigned NOT NULL DEFAULT 0,
  `enchantments` text NOT NULL,
  `randomPropertyId` SMALLINT NOT NULL DEFAULT 0,
  `durability` SMALLINT unsigned NOT NULL DEFAULT 0,
  `playedTime` INT unsigned NOT NULL DEFAULT 0,
  `text` text,
  PRIMARY KEY (`guid`),
  KEY `idx_owner_guid` (`owner_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Item System';

-- Dumpar data för tabell acore_characters.item_instance: ~0 rows (ungefär)
DELETE FROM `item_instance`;
/*!40000 ALTER TABLE `item_instance` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_instance` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
