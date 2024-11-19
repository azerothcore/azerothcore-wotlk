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

-- Dumping structure for table acore_characters.updates
DROP TABLE IF EXISTS `updates`;
CREATE TABLE IF NOT EXISTS `updates` (
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'filename with extension of the update.',
  `hash` char(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'sha1 hash of the sql file.',
  `state` enum('RELEASED','CUSTOM','MODULE','ARCHIVED') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'RELEASED' COMMENT 'defines if an update is released or archived.',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'timestamp when the query was applied.',
  `speed` int unsigned NOT NULL DEFAULT '0' COMMENT 'time the query takes to apply in ms.',
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='List of all applied updates in this database.';

-- Dumping data for table acore_characters.updates: ~5 rows (approximately)
DELETE FROM `updates`;
INSERT INTO `updates` (`name`, `hash`, `state`, `timestamp`, `speed`) VALUES
	('2023_04_24_00.sql', 'D164A70B22B2462464484614018C3218B3259AE4', 'RELEASED', '2024-01-20 13:25:01', 30),
	('2023_05_23_00.sql', 'A1A442D3F5049CDA2C067761F768C08BEFFFD26A', 'RELEASED', '2024-01-20 13:25:01', 35),
	('2023_09_16_00.sql', '5760BA953E3F0C73492B979A33A86771B82CE464', 'RELEASED', '2024-01-20 13:25:01', 68),
	('2024_01_20_00.sql', 'FB9F840C7601C4F0939D23E87377D7DD9D145094', 'RELEASED', '2024-01-20 13:25:01', 26),
	('2024_07_05_00.sql', '1C9590EBB81D192A2DF101D6B0B2178E45306500', 'RELEASED', '2024-07-16 22:46:08', 88);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
