-- MySQL dump 10.13  Distrib 8.4.3, for Win64 (x86_64)
--
-- Host: localhost    Database: acore_world
-- ------------------------------------------------------
-- Server version	8.4.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `player_shapeshift_model`
--

DROP TABLE IF EXISTS `player_shapeshift_model`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_shapeshift_model` (
  `ShapeshiftID` tinyint unsigned NOT NULL,
  `RaceID` tinyint unsigned NOT NULL,
  `CustomizationID` tinyint unsigned NOT NULL,
  `GenderID` tinyint unsigned NOT NULL,
  `ModelID` int unsigned NOT NULL,
  PRIMARY KEY (`ShapeshiftID`,`RaceID`,`CustomizationID`,`GenderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_shapeshift_model`
--

LOCK TABLES `player_shapeshift_model` WRITE;
/*!40000 ALTER TABLE `player_shapeshift_model` DISABLE KEYS */;
INSERT INTO `player_shapeshift_model` VALUES
(1,4,0,2,29407),
(1,4,1,2,29407),
(1,4,2,2,29407),
(1,4,3,2,29406),
(1,4,4,2,29408),
(1,4,7,2,29405),
(1,4,8,2,29405),
(1,4,255,2,892),
(1,6,0,0,29412),
(1,6,0,1,29412),
(1,6,1,0,29412),
(1,6,1,1,29412),
(1,6,2,0,29412),
(1,6,2,1,29412),
(1,6,3,0,29412),
(1,6,3,1,29412),
(1,6,4,0,29412),
(1,6,4,1,29411),
(1,6,5,0,29412),
(1,6,5,1,29411),
(1,6,6,0,29411),
(1,6,6,1,29410),
(1,6,7,0,29411),
(1,6,7,1,29410),
(1,6,8,0,29411),
(1,6,9,0,29410),
(1,6,10,0,29410),
(1,6,10,1,29409),
(1,6,11,0,29410),
(1,6,12,0,29409),
(1,6,13,0,29409),
(1,6,14,0,29409),
(1,6,18,0,29409),
(1,6,255,0,8571),
(1,6,255,1,8571),
(5,4,0,2,29413),
(5,4,1,2,29413),
(5,4,2,2,29413),
(5,4,3,2,29417),
(5,4,4,2,29416),
(5,4,6,2,29414),
(5,4,255,2,2281),
(5,6,0,0,29418),
(5,6,0,1,29418),
(5,6,1,0,29418),
(5,6,1,1,29418),
(5,6,2,0,29418),
(5,6,2,1,29419),
(5,6,3,0,29419),
(5,6,3,1,29419),
(5,6,4,0,29419),
(5,6,5,0,29419),
(5,6,6,1,29420),
(5,6,7,1,29420),
(5,6,8,1,29420),
(5,6,9,0,29420),
(5,6,9,1,29420),
(5,6,10,0,29420),
(5,6,10,1,29421),
(5,6,11,0,29420),
(5,6,12,0,29419),
(5,6,13,0,29419),
(5,6,14,0,29419),
(5,6,15,0,29420),
(5,6,16,0,29420),
(5,6,17,0,29420),
(5,6,18,0,29421),
(5,6,255,0,2289),
(5,6,255,1,2289),
(8,4,0,2,29413),
(8,4,1,2,29413),
(8,4,2,2,29413),
(8,4,3,2,29417),
(8,4,4,2,29416),
(8,4,6,2,29414),
(8,4,255,2,2281),
(8,6,0,0,29418),
(8,6,0,1,29418),
(8,6,1,0,29418),
(8,6,1,1,29418),
(8,6,2,0,29418),
(8,6,2,1,29419),
(8,6,3,0,29419),
(8,6,3,1,29419),
(8,6,4,0,29419),
(8,6,5,0,29419),
(8,6,6,1,29420),
(8,6,7,1,29420),
(8,6,8,1,29420),
(8,6,9,0,29420),
(8,6,9,1,29420),
(8,6,10,0,29420),
(8,6,10,1,29421),
(8,6,11,0,29420),
(8,6,12,0,29419),
(8,6,13,0,29419),
(8,6,14,0,29419),
(8,6,15,0,29420),
(8,6,16,0,29420),
(8,6,17,0,29420),
(8,6,18,0,29421),
(8,6,255,0,2289),
(8,6,255,1,2289),
(27,4,255,2,21243),
(27,6,255,2,21244),
(29,4,255,2,20857),
(29,6,255,2,20872);
/*!40000 ALTER TABLE `player_shapeshift_model` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-29 17:54:20
