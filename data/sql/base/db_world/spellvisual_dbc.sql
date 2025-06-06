-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: acore_world
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `spellvisual_dbc`
--

DROP TABLE IF EXISTS `spellvisual_dbc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spellvisual_dbc` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spellvisual_dbc`
--

LOCK TABLES `spellvisual_dbc` WRITE;
/*!40000 ALTER TABLE `spellvisual_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `spellvisual_dbc` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-17 22:34:43

