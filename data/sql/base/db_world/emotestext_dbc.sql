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

-- Dumping structure for table acore_world.emotestext_dbc
DROP TABLE IF EXISTS `emotestext_dbc`;
CREATE TABLE IF NOT EXISTS `emotestext_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `EmoteID` int NOT NULL DEFAULT '0',
  `EmoteText_1` int NOT NULL DEFAULT '0',
  `EmoteText_2` int NOT NULL DEFAULT '0',
  `EmoteText_3` int NOT NULL DEFAULT '0',
  `EmoteText_4` int NOT NULL DEFAULT '0',
  `EmoteText_5` int NOT NULL DEFAULT '0',
  `EmoteText_6` int NOT NULL DEFAULT '0',
  `EmoteText_7` int NOT NULL DEFAULT '0',
  `EmoteText_8` int NOT NULL DEFAULT '0',
  `EmoteText_9` int NOT NULL DEFAULT '0',
  `EmoteText_10` int NOT NULL DEFAULT '0',
  `EmoteText_11` int NOT NULL DEFAULT '0',
  `EmoteText_12` int NOT NULL DEFAULT '0',
  `EmoteText_13` int NOT NULL DEFAULT '0',
  `EmoteText_14` int NOT NULL DEFAULT '0',
  `EmoteText_15` int NOT NULL DEFAULT '0',
  `EmoteText_16` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table acore_world.emotestext_dbc: ~0 rows (approximately)
DELETE FROM `emotestext_dbc`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
