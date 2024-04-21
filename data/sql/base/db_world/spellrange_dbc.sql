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

-- Dumping structure for table acore_world.spellrange_dbc
DROP TABLE IF EXISTS `spellrange_dbc`;
CREATE TABLE IF NOT EXISTS `spellrange_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `RangeMin_1` float NOT NULL DEFAULT '0',
  `RangeMin_2` float NOT NULL DEFAULT '0',
  `RangeMax_1` float NOT NULL DEFAULT '0',
  `RangeMax_2` float NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `DisplayName_Lang_enUS` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayName_Lang_enGB` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayName_Lang_koKR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayName_Lang_frFR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayName_Lang_deDE` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayName_Lang_enCN` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayName_Lang_zhCN` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayName_Lang_enTW` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayName_Lang_zhTW` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayName_Lang_esES` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayName_Lang_esMX` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayName_Lang_ruRU` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayName_Lang_ptPT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayName_Lang_ptBR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayName_Lang_itIT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayName_Lang_Unk` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayName_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `DisplayNameShort_Lang_enUS` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayNameShort_Lang_enGB` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayNameShort_Lang_koKR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayNameShort_Lang_frFR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayNameShort_Lang_deDE` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayNameShort_Lang_enCN` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayNameShort_Lang_zhCN` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayNameShort_Lang_enTW` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayNameShort_Lang_zhTW` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayNameShort_Lang_esES` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayNameShort_Lang_esMX` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayNameShort_Lang_ruRU` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayNameShort_Lang_ptPT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayNameShort_Lang_ptBR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayNameShort_Lang_itIT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayNameShort_Lang_Unk` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayNameShort_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table acore_world.spellrange_dbc: ~0 rows (approximately)
DELETE FROM `spellrange_dbc`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
