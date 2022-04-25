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

-- Dumpar struktur för tabell acore_characters.item_loot_storage
DROP TABLE IF EXISTS `item_loot_storage`;
CREATE TABLE IF NOT EXISTS `item_loot_storage` (
  `containerGUID` INT unsigned NOT NULL,
  `itemid` INT unsigned NOT NULL,
  `count` INT unsigned NOT NULL,
  `item_index` INT unsigned NOT NULL DEFAULT 0,
  `randomPropertyId` INT NOT NULL,
  `randomSuffix` INT unsigned NOT NULL,
  `follow_loot_rules` TINYINT unsigned NOT NULL,
  `freeforall` TINYINT unsigned NOT NULL,
  `is_blocked` TINYINT unsigned NOT NULL,
  `is_counted` TINYINT unsigned NOT NULL,
  `is_underthreshold` TINYINT unsigned NOT NULL,
  `needs_quest` TINYINT unsigned NOT NULL,
  `conditionLootId` INT NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_characters.item_loot_storage: ~0 rows (ungefär)
DELETE FROM `item_loot_storage`;
/*!40000 ALTER TABLE `item_loot_storage` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_loot_storage` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
