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

-- Dumping structure for table acore_world.prospecting_loot_template
DROP TABLE IF EXISTS `prospecting_loot_template`;
CREATE TABLE IF NOT EXISTS `prospecting_loot_template` (
  `Entry` int unsigned NOT NULL DEFAULT '0',
  `Item` int unsigned NOT NULL DEFAULT '0',
  `Reference` int NOT NULL DEFAULT '0',
  `Chance` float NOT NULL DEFAULT '100',
  `QuestRequired` tinyint NOT NULL DEFAULT '0',
  `LootMode` smallint unsigned NOT NULL DEFAULT '1',
  `GroupId` tinyint unsigned NOT NULL DEFAULT '0',
  `MinCount` tinyint unsigned NOT NULL DEFAULT '1',
  `MaxCount` tinyint unsigned NOT NULL DEFAULT '1',
  `Comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Entry`,`Item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Loot System';

-- Dumping data for table acore_world.prospecting_loot_template: ~37 rows (approximately)
DELETE FROM `prospecting_loot_template`;
INSERT INTO `prospecting_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
	(2770, 774, 0, 0, 0, 1, 1, 1, 1, 'Malachite'),
	(2770, 818, 0, 0, 0, 1, 1, 1, 1, 'Tigerseye'),
	(2770, 1210, 0, 10, 0, 1, 0, 1, 1, 'Shadowgem'),
	(2771, 1, 13000, 10, 0, 1, 0, 1, 1, '(ReferenceTable)'),
	(2771, 1206, 0, 0, 0, 1, 1, 1, 2, 'Moss Agate'),
	(2771, 1210, 0, 0, 0, 1, 1, 1, 2, 'Shadowgem'),
	(2771, 1705, 0, 0, 0, 1, 1, 1, 2, 'Lesser Moonstone'),
	(2772, 1529, 0, 30, 0, 1, 1, 1, 2, 'Jade'),
	(2772, 1705, 0, 30, 0, 1, 1, 1, 2, 'Lesser Moonstone'),
	(2772, 3864, 0, 30, 0, 1, 1, 1, 2, 'Citrine'),
	(2772, 7909, 0, 5, 0, 1, 1, 1, 1, 'Aquamarine'),
	(2772, 7910, 0, 5, 0, 1, 1, 1, 1, 'Star Ruby'),
	(3858, 3864, 0, 30, 0, 1, 1, 1, 2, 'Citrine'),
	(3858, 7909, 0, 30, 0, 1, 1, 1, 2, 'Aquamarine'),
	(3858, 7910, 0, 30, 0, 1, 1, 1, 2, 'Star Ruby'),
	(3858, 12361, 0, 2.5, 0, 1, 1, 1, 1, 'Blue Sapphire'),
	(3858, 12364, 0, 2.5, 0, 1, 1, 1, 1, 'Huge Emerald'),
	(3858, 12799, 0, 2.5, 0, 1, 1, 1, 1, 'Large Opal'),
	(3858, 12800, 0, 2.5, 0, 1, 1, 1, 1, 'Azerothian Diamond'),
	(10620, 1, -13001, 10, 0, 1, 1, 1, 1, '(ReferenceTable)'),
	(10620, 7910, 0, 30, 0, 1, 1, 1, 2, 'Star Ruby'),
	(10620, 12361, 0, 15, 0, 1, 1, 1, 2, 'Blue Sapphire'),
	(10620, 12364, 0, 15, 0, 1, 1, 1, 2, 'Huge Emerald'),
	(10620, 12799, 0, 15, 0, 1, 1, 1, 2, 'Large Opal'),
	(10620, 12800, 0, 15, 0, 1, 1, 1, 2, 'Azerothian Diamond'),
	(23424, 1, 1000, 100, 0, 1, 1, 1, 1, '(ReferenceTable)'),
	(23425, 1, 13001, 100, 0, 1, 1, 1, 1, '(ReferenceTable)'),
	(23425, 2, 13002, 24, 0, 1, 1, 1, 1, '(ReferenceTable)'),
	(23425, 3, 13001, 15, 0, 1, 1, 1, 1, '(ReferenceTable)'),
	(23425, 24243, 0, 100, 0, 1, 0, 1, 1, 'Adamantite Powder'),
	(36909, 1, 1001, 100, 0, 1, 1, 1, 1, '(ReferenceTable)'),
	(36910, 1, 13005, 20, 0, 1, 0, 1, 1, '(ReferenceTable)'),
	(36910, 2, 1002, 100, 0, 1, 1, 1, 1, '(ReferenceTable)'),
	(36910, 3, 1003, 75, 0, 1, 1, 1, 1, '(ReferenceTable)'),
	(36910, 46849, 0, 75, 0, 1, 0, 1, 1, 'Titanium Powder'),
	(36912, 1, 1003, 85, 0, 1, 0, 1, 1, '(ReferenceTable)'),
	(36912, 2, 1004, 100, 0, 1, 1, 1, 1, '(ReferenceTable)');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
