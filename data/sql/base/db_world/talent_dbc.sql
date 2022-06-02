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

-- Dumpar struktur för tabell acore_world.talent_dbc
DROP TABLE IF EXISTS `talent_dbc`;
CREATE TABLE IF NOT EXISTS `talent_dbc` (
  `ID` INT NOT NULL DEFAULT 0,
  `TabID` INT NOT NULL DEFAULT 0,
  `TierID` INT NOT NULL DEFAULT 0,
  `ColumnIndex` INT NOT NULL DEFAULT 0,
  `SpellRank_1` INT NOT NULL DEFAULT 0,
  `SpellRank_2` INT NOT NULL DEFAULT 0,
  `SpellRank_3` INT NOT NULL DEFAULT 0,
  `SpellRank_4` INT NOT NULL DEFAULT 0,
  `SpellRank_5` INT NOT NULL DEFAULT 0,
  `SpellRank_6` INT NOT NULL DEFAULT 0,
  `SpellRank_7` INT NOT NULL DEFAULT 0,
  `SpellRank_8` INT NOT NULL DEFAULT 0,
  `SpellRank_9` INT NOT NULL DEFAULT 0,
  `PrereqTalent_1` INT NOT NULL DEFAULT 0,
  `PrereqTalent_2` INT NOT NULL DEFAULT 0,
  `PrereqTalent_3` INT NOT NULL DEFAULT 0,
  `PrereqRank_1` INT NOT NULL DEFAULT 0,
  `PrereqRank_2` INT NOT NULL DEFAULT 0,
  `PrereqRank_3` INT NOT NULL DEFAULT 0,
  `Flags` INT NOT NULL DEFAULT 0,
  `RequiredSpellID` INT NOT NULL DEFAULT 0,
  `CategoryMask_1` INT NOT NULL DEFAULT 0,
  `CategoryMask_2` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_world.talent_dbc: 0 rows
DELETE FROM `talent_dbc`;
/*!40000 ALTER TABLE `talent_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `talent_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
