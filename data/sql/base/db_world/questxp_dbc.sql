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

-- Dumpar struktur för tabell acore_world.questxp_dbc
DROP TABLE IF EXISTS `questxp_dbc`;
CREATE TABLE IF NOT EXISTS `questxp_dbc` (
  `ID` INT NOT NULL DEFAULT 0,
  `Difficulty_1` INT NOT NULL DEFAULT 0,
  `Difficulty_2` INT NOT NULL DEFAULT 0,
  `Difficulty_3` INT NOT NULL DEFAULT 0,
  `Difficulty_4` INT NOT NULL DEFAULT 0,
  `Difficulty_5` INT NOT NULL DEFAULT 0,
  `Difficulty_6` INT NOT NULL DEFAULT 0,
  `Difficulty_7` INT NOT NULL DEFAULT 0,
  `Difficulty_8` INT NOT NULL DEFAULT 0,
  `Difficulty_9` INT NOT NULL DEFAULT 0,
  `Difficulty_10` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_world.questxp_dbc: 0 rows
DELETE FROM `questxp_dbc`;
/*!40000 ALTER TABLE `questxp_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `questxp_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
