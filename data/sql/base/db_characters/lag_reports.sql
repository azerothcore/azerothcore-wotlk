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

-- Dumpar struktur för tabell acore_characters.lag_reports
DROP TABLE IF EXISTS `lag_reports`;
CREATE TABLE IF NOT EXISTS `lag_reports` (
  `reportId` INT unsigned NOT NULL AUTO_INCREMENT,
  `guid` INT unsigned NOT NULL DEFAULT 0,
  `lagType` TINYINT unsigned NOT NULL DEFAULT 0,
  `mapId` SMALLINT unsigned NOT NULL DEFAULT 0,
  `posX` float NOT NULL DEFAULT 0,
  `posY` float NOT NULL DEFAULT 0,
  `posZ` float NOT NULL DEFAULT 0,
  `latency` INT unsigned NOT NULL DEFAULT 0,
  `createTime` INT unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`reportId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Player System';

-- Dumpar data för tabell acore_characters.lag_reports: ~0 rows (ungefär)
DELETE FROM `lag_reports`;
/*!40000 ALTER TABLE `lag_reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `lag_reports` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
