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

-- Dumpar struktur för tabell acore_world.creature_movement_override
DROP TABLE IF EXISTS `creature_movement_override`;
CREATE TABLE IF NOT EXISTS `creature_movement_override` (
  `SpawnId` INT unsigned NOT NULL DEFAULT 0,
  `Ground` TINYINT unsigned DEFAULT NULL,
  `Swim` TINYINT unsigned DEFAULT NULL,
  `Flight` TINYINT unsigned DEFAULT NULL,
  `Rooted` TINYINT unsigned DEFAULT NULL,
  `Chase` TINYINT unsigned DEFAULT NULL,
  `Random` TINYINT unsigned DEFAULT NULL,
  `InteractionPauseTimer` INT unsigned DEFAULT NULL COMMENT 'Time (in milliseconds) during which creature will not move after interaction with player',
  PRIMARY KEY (`SpawnId`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_world.creature_movement_override: 11 rows
DELETE FROM `creature_movement_override`;
/*!40000 ALTER TABLE `creature_movement_override` DISABLE KEYS */;
INSERT INTO `creature_movement_override` (`SpawnId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
	(125724, 1, 1, 2, 0, 0, 0, NULL),
	(106339, 1, 1, 2, 0, 0, 0, NULL),
	(106340, 1, 1, 2, 0, 0, 0, NULL),
	(117664, 1, 0, 1, 0, 0, 0, NULL),
	(117670, 1, 0, 1, 0, 0, 0, NULL),
	(117671, 1, 0, 1, 0, 0, 0, NULL),
	(117672, 1, 0, 1, 0, 0, 0, NULL),
	(117677, 1, 0, 1, 0, 0, 0, NULL),
	(247156, 1, 0, 1, 1, 0, 0, NULL),
	(247157, 1, 0, 1, 1, 0, 0, NULL),
	(130896, 1, 0, 1, 0, 0, 0, NULL);
/*!40000 ALTER TABLE `creature_movement_override` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
