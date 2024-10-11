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

-- Dumping structure for table acore_world.spellvisual_dbc
DROP TABLE IF EXISTS `spellvisual_dbc`;
CREATE TABLE IF NOT EXISTS `spellvisual_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `PrecastKit` int NOT NULL DEFAULT '0',
  `CastKit` int NOT NULL DEFAULT '0',
  `ImpactKit` int NOT NULL DEFAULT '0',
  `StateKit` int NOT NULL DEFAULT '0',
  `StateDoneKit` int NOT NULL DEFAULT '0',
  `ChannelKit` int NOT NULL DEFAULT '0',
  `HasMissile` int NOT NULL DEFAULT '0',
  `MissileModel` int NOT NULL DEFAULT '0',
  `MissilePathType` int NOT NULL DEFAULT '0',
  `MissileDestinationAttachment` int NOT NULL DEFAULT '0',
  `MissileSound` int NOT NULL DEFAULT '0',
  `AnimEventSoundID` int NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `CasterImpactKit` int NOT NULL DEFAULT '0',
  `TargetImpactKit` int NOT NULL DEFAULT '0',
  `MissileAttachment` int NOT NULL DEFAULT '0',
  `MissileFollowGroundHeight` int NOT NULL DEFAULT '0',
  `MissileFollowGroundDropSpeed` int NOT NULL DEFAULT '0',
  `MissileFollowGroundApproach` int NOT NULL DEFAULT '0',
  `MissileFollowGroundFlags` int NOT NULL DEFAULT '0',
  `MissileMotion` int NOT NULL DEFAULT '0',
  `MissileTargetingKit` int NOT NULL DEFAULT '0',
  `InstantAreaKit` int NOT NULL DEFAULT '0',
  `ImpactAreaKit` int NOT NULL DEFAULT '0',
  `PersistentAreaKit` int NOT NULL DEFAULT '0',
  `MissileCastOffsetX` float NOT NULL DEFAULT '0',
  `MissileCastOffsetY` float NOT NULL DEFAULT '0',
  `MissileCastOffsetZ` float NOT NULL DEFAULT '0',
  `MissileImpactOffsetX` float NOT NULL DEFAULT '0',
  `MissileImpactOffsetY` float NOT NULL DEFAULT '0',
  `MissileImpactOffsetZ` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table acore_world.spellvisual_dbc: ~0 rows (approximately)
DELETE FROM `spellvisual_dbc`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
