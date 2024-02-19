-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.1.0 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.3.0.6589
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table acore_characters.item_loot_storage
DROP TABLE IF EXISTS `item_loot_storage`;
CREATE TABLE IF NOT EXISTS `item_loot_storage` (
  `containerGUID` int unsigned NOT NULL,
  `itemid` int unsigned NOT NULL,
  `count` int unsigned NOT NULL,
  `item_index` int unsigned NOT NULL DEFAULT '0',
  `randomPropertyId` int NOT NULL,
  `randomSuffix` int unsigned NOT NULL,
  `follow_loot_rules` tinyint unsigned NOT NULL,
  `freeforall` tinyint unsigned NOT NULL,
  `is_blocked` tinyint unsigned NOT NULL,
  `is_counted` tinyint unsigned NOT NULL,
  `is_underthreshold` tinyint unsigned NOT NULL,
  `needs_quest` tinyint unsigned NOT NULL,
  `conditionLootId` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table acore_characters.item_loot_storage: ~0 rows (approximately)
DELETE FROM `item_loot_storage`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
