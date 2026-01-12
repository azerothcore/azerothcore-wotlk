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
-- Table structure for table `vehicle_seat_addon`
--

DROP TABLE IF EXISTS `vehicle_seat_addon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicle_seat_addon` (
  `SeatEntry` int unsigned NOT NULL COMMENT 'VehicleSeatEntry.dbc identifier',
  `SeatOrientation` float DEFAULT '0' COMMENT 'Seat Orientation override value',
  `ExitParamX` float DEFAULT '0',
  `ExitParamY` float DEFAULT '0',
  `ExitParamZ` float DEFAULT '0',
  `ExitParamO` float DEFAULT '0',
  `ExitParamValue` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`SeatEntry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle_seat_addon`
--

LOCK TABLES `vehicle_seat_addon` WRITE;
/*!40000 ALTER TABLE `vehicle_seat_addon` DISABLE KEYS */;
INSERT INTO `vehicle_seat_addon` VALUES
(742,0,0,-2,0,0,1),
(861,0,-2,2,0,0,1),
(862,0,-2,3,0,0,1),
(1472,0,2802.18,7054.91,-0.6,4.67,2),
(1473,0,2802.18,7054.91,-0.6,4.67,2),
(1474,0,2802.18,7054.91,-0.6,4.67,2),
(1475,0,2802.18,7054.91,-0.6,4.67,2),
(1476,0,2802.18,7054.91,-0.6,4.67,2),
(1682,0,6708.17,5130.74,-19.388,4.83608,2),
(2097,0,12,0,4,0,1),
(2101,0,0,0,4,0,1),
(2172,0,40,0,0,0,1),
(2178,0,7.9178,0,-0.4759,0,1),
(2179,0,5.9427,-5.0106,-0.4759,0,1),
(2180,0,3.3464,5.0329,-0.4759,0,1),
(2245,0,3,-4,3,0,1),
(2764,0,-2,2,0,0,1),
(2765,0,-2,-2,0,0,1),
(2767,0,-2,2,0,0,1),
(2768,0,-2,-2,0,0,1),
(2771,0,-2,-2,0,0,1),
(2772,0,-2,2,0,0,1),
(3129,0,0,-2,0,0,1),
(3690,0,1776,-24,448.75,0,2),
(3691,0,1776,-24,448.75,0,2),
(3692,0,1776,-24,448.75,0,2),
(6446,0,-1,4,3,0,1),
(6447,0,1,4,3,0,1),
(7326,0,-1,4,3,0,1),
(7327,0,1,4,3,0,1),
(7328,0,-1,4,3,0,1),
(7329,0,1,4,3,0,1);
/*!40000 ALTER TABLE `vehicle_seat_addon` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-29 17:54:47
