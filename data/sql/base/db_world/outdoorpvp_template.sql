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

-- Dumpar struktur för tabell acore_world.outdoorpvp_template
DROP TABLE IF EXISTS `outdoorpvp_template`;
CREATE TABLE IF NOT EXISTS `outdoorpvp_template` (
  `TypeId` tinyint unsigned NOT NULL,
  `ScriptName` char(64) NOT NULL DEFAULT '',
  `comment` text,
  PRIMARY KEY (`TypeId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='OutdoorPvP Templates';

-- Dumpar data för tabell acore_world.outdoorpvp_template: 7 rows
DELETE FROM `outdoorpvp_template`;
/*!40000 ALTER TABLE `outdoorpvp_template` DISABLE KEYS */;
INSERT INTO `outdoorpvp_template` (`TypeId`, `ScriptName`, `comment`) VALUES
	(1, 'outdoorpvp_hp', 'Hellfire Peninsula'),
	(2, 'outdoorpvp_na', 'Nagrand'),
	(3, 'outdoorpvp_tf', 'Terokkar Forest'),
	(4, 'outdoorpvp_zm', 'Zangarmarsh'),
	(5, 'outdoorpvp_si', 'Silithus'),
	(6, 'outdoorpvp_ep', 'Eastern Plaguelands'),
	(7, 'outdoorpvp_gh', 'Grizzly Hills');
/*!40000 ALTER TABLE `outdoorpvp_template` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
