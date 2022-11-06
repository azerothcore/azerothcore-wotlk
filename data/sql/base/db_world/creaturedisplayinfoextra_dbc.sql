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

-- Dumpar struktur för tabell acore_world.creaturedisplayinfoextra_dbc
DROP TABLE IF EXISTS `creaturedisplayinfoextra_dbc`;
CREATE TABLE IF NOT EXISTS `creaturedisplayinfoextra_dbc` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `DisplayRaceID` int unsigned NOT NULL DEFAULT '0',
  `DisplaySexID` int unsigned NOT NULL DEFAULT '0',
  `SkinID` int unsigned NOT NULL DEFAULT '0',
  `FaceID` int unsigned NOT NULL DEFAULT '0',
  `HairStyleID` int unsigned NOT NULL DEFAULT '0',
  `HairColorID` int unsigned NOT NULL DEFAULT '0',
  `FacialHairID` int unsigned NOT NULL DEFAULT '0',
  `NPCItemDisplay1` int unsigned NOT NULL DEFAULT '0',
  `NPCItemDisplay2` int unsigned NOT NULL DEFAULT '0',
  `NPCItemDisplay3` int unsigned NOT NULL DEFAULT '0',
  `NPCItemDisplay4` int unsigned NOT NULL DEFAULT '0',
  `NPCItemDisplay5` int unsigned NOT NULL DEFAULT '0',
  `NPCItemDisplay6` int unsigned NOT NULL DEFAULT '0',
  `NPCItemDisplay7` int unsigned NOT NULL DEFAULT '0',
  `NPCItemDisplay8` int unsigned NOT NULL DEFAULT '0',
  `NPCItemDisplay9` int unsigned NOT NULL DEFAULT '0',
  `NPCItemDisplay10` int unsigned NOT NULL DEFAULT '0',
  `NPCItemDisplay11` int unsigned NOT NULL DEFAULT '0',
  `Flags` int unsigned NOT NULL DEFAULT '0',
  `BakeName` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumpar data för tabell acore_world.creaturedisplayinfoextra_dbc: 0 rows
DELETE FROM `creaturedisplayinfoextra_dbc`;
/*!40000 ALTER TABLE `creaturedisplayinfoextra_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `creaturedisplayinfoextra_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
