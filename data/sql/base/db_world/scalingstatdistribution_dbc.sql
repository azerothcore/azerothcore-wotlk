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

-- Dumpar struktur för tabell acore_world.scalingstatdistribution_dbc
DROP TABLE IF EXISTS `scalingstatdistribution_dbc`;
CREATE TABLE IF NOT EXISTS `scalingstatdistribution_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `StatID_1` int NOT NULL DEFAULT '0',
  `StatID_2` int NOT NULL DEFAULT '0',
  `StatID_3` int NOT NULL DEFAULT '0',
  `StatID_4` int NOT NULL DEFAULT '0',
  `StatID_5` int NOT NULL DEFAULT '0',
  `StatID_6` int NOT NULL DEFAULT '0',
  `StatID_7` int NOT NULL DEFAULT '0',
  `StatID_8` int NOT NULL DEFAULT '0',
  `StatID_9` int NOT NULL DEFAULT '0',
  `StatID_10` int NOT NULL DEFAULT '0',
  `Bonus_1` int NOT NULL DEFAULT '0',
  `Bonus_2` int NOT NULL DEFAULT '0',
  `Bonus_3` int NOT NULL DEFAULT '0',
  `Bonus_4` int NOT NULL DEFAULT '0',
  `Bonus_5` int NOT NULL DEFAULT '0',
  `Bonus_6` int NOT NULL DEFAULT '0',
  `Bonus_7` int NOT NULL DEFAULT '0',
  `Bonus_8` int NOT NULL DEFAULT '0',
  `Bonus_9` int NOT NULL DEFAULT '0',
  `Bonus_10` int NOT NULL DEFAULT '0',
  `Maxlevel` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_world.scalingstatdistribution_dbc: 0 rows
DELETE FROM `scalingstatdistribution_dbc`;
/*!40000 ALTER TABLE `scalingstatdistribution_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `scalingstatdistribution_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
