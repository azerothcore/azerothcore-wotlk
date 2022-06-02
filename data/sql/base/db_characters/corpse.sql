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

-- Dumpar struktur för tabell acore_characters.corpse
DROP TABLE IF EXISTS `corpse`;
CREATE TABLE IF NOT EXISTS `corpse` (
  `guid` INT unsigned NOT NULL DEFAULT 0 COMMENT 'Character Global Unique Identifier',
  `posX` float NOT NULL DEFAULT 0,
  `posY` float NOT NULL DEFAULT 0,
  `posZ` float NOT NULL DEFAULT 0,
  `orientation` float NOT NULL DEFAULT 0,
  `mapId` SMALLINT unsigned NOT NULL DEFAULT 0 COMMENT 'Map Identifier',
  `phaseMask` INT unsigned NOT NULL DEFAULT 1,
  `displayId` INT unsigned NOT NULL DEFAULT 0,
  `itemCache` text NOT NULL,
  `bytes1` INT unsigned NOT NULL DEFAULT 0,
  `bytes2` INT unsigned NOT NULL DEFAULT 0,
  `guildId` INT unsigned NOT NULL DEFAULT 0,
  `flags` TINYINT unsigned NOT NULL DEFAULT 0,
  `dynFlags` TINYINT unsigned NOT NULL DEFAULT 0,
  `time` INT unsigned NOT NULL DEFAULT 0,
  `corpseType` TINYINT unsigned NOT NULL DEFAULT 0,
  `instanceId` INT unsigned NOT NULL DEFAULT 0 COMMENT 'Instance Identifier',
  PRIMARY KEY (`guid`),
  KEY `idx_type` (`corpseType`),
  KEY `idx_instance` (`instanceId`),
  KEY `idx_time` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Death System';

-- Dumpar data för tabell acore_characters.corpse: ~0 rows (ungefär)
DELETE FROM `corpse`;
/*!40000 ALTER TABLE `corpse` DISABLE KEYS */;
/*!40000 ALTER TABLE `corpse` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
