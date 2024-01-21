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

-- Dumping structure for table acore_world.itemset_dbc
DROP TABLE IF EXISTS `itemset_dbc`;
CREATE TABLE IF NOT EXISTS `itemset_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Name_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `ItemID_1` int NOT NULL DEFAULT '0',
  `ItemID_2` int NOT NULL DEFAULT '0',
  `ItemID_3` int NOT NULL DEFAULT '0',
  `ItemID_4` int NOT NULL DEFAULT '0',
  `ItemID_5` int NOT NULL DEFAULT '0',
  `ItemID_6` int NOT NULL DEFAULT '0',
  `ItemID_7` int NOT NULL DEFAULT '0',
  `ItemID_8` int NOT NULL DEFAULT '0',
  `ItemID_9` int NOT NULL DEFAULT '0',
  `ItemID_10` int NOT NULL DEFAULT '0',
  `ItemID_11` int NOT NULL DEFAULT '0',
  `ItemID_12` int NOT NULL DEFAULT '0',
  `ItemID_13` int NOT NULL DEFAULT '0',
  `ItemID_14` int NOT NULL DEFAULT '0',
  `ItemID_15` int NOT NULL DEFAULT '0',
  `ItemID_16` int NOT NULL DEFAULT '0',
  `ItemID_17` int NOT NULL DEFAULT '0',
  `SetSpellID_1` int NOT NULL DEFAULT '0',
  `SetSpellID_2` int NOT NULL DEFAULT '0',
  `SetSpellID_3` int NOT NULL DEFAULT '0',
  `SetSpellID_4` int NOT NULL DEFAULT '0',
  `SetSpellID_5` int NOT NULL DEFAULT '0',
  `SetSpellID_6` int NOT NULL DEFAULT '0',
  `SetSpellID_7` int NOT NULL DEFAULT '0',
  `SetSpellID_8` int NOT NULL DEFAULT '0',
  `SetThreshold_1` int NOT NULL DEFAULT '0',
  `SetThreshold_2` int NOT NULL DEFAULT '0',
  `SetThreshold_3` int NOT NULL DEFAULT '0',
  `SetThreshold_4` int NOT NULL DEFAULT '0',
  `SetThreshold_5` int NOT NULL DEFAULT '0',
  `SetThreshold_6` int NOT NULL DEFAULT '0',
  `SetThreshold_7` int NOT NULL DEFAULT '0',
  `SetThreshold_8` int NOT NULL DEFAULT '0',
  `RequiredSkill` int NOT NULL DEFAULT '0',
  `RequiredSkillRank` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table acore_world.itemset_dbc: ~0 rows (approximately)
DELETE FROM `itemset_dbc`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
