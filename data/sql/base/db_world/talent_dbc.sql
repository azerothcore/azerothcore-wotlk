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

-- Dumping structure for table acore_world.talent_dbc
DROP TABLE IF EXISTS `talent_dbc`;
CREATE TABLE IF NOT EXISTS `talent_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `TabID` int NOT NULL DEFAULT '0',
  `TierID` int NOT NULL DEFAULT '0',
  `ColumnIndex` int NOT NULL DEFAULT '0',
  `SpellRank_1` int NOT NULL DEFAULT '0',
  `SpellRank_2` int NOT NULL DEFAULT '0',
  `SpellRank_3` int NOT NULL DEFAULT '0',
  `SpellRank_4` int NOT NULL DEFAULT '0',
  `SpellRank_5` int NOT NULL DEFAULT '0',
  `SpellRank_6` int NOT NULL DEFAULT '0',
  `SpellRank_7` int NOT NULL DEFAULT '0',
  `SpellRank_8` int NOT NULL DEFAULT '0',
  `SpellRank_9` int NOT NULL DEFAULT '0',
  `PrereqTalent_1` int NOT NULL DEFAULT '0',
  `PrereqTalent_2` int NOT NULL DEFAULT '0',
  `PrereqTalent_3` int NOT NULL DEFAULT '0',
  `PrereqRank_1` int NOT NULL DEFAULT '0',
  `PrereqRank_2` int NOT NULL DEFAULT '0',
  `PrereqRank_3` int NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `RequiredSpellID` int NOT NULL DEFAULT '0',
  `CategoryMask_1` int NOT NULL DEFAULT '0',
  `CategoryMask_2` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table acore_world.talent_dbc: ~0 rows (approximately)
DELETE FROM `talent_dbc`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
