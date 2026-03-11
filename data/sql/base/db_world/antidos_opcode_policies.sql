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
-- Table structure for table `antidos_opcode_policies`
--

DROP TABLE IF EXISTS `antidos_opcode_policies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `antidos_opcode_policies` (
  `Opcode` smallint unsigned NOT NULL,
  `Policy` tinyint unsigned NOT NULL,
  `MaxAllowedCount` smallint unsigned NOT NULL,
  PRIMARY KEY (`Opcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `antidos_opcode_policies`
--

LOCK TABLES `antidos_opcode_policies` WRITE;
/*!40000 ALTER TABLE `antidos_opcode_policies` DISABLE KEYS */;
INSERT INTO `antidos_opcode_policies` VALUES
(54,1,3),
(55,1,3),
(56,1,10),
(98,1,200),
(102,1,200),
(105,1,10),
(106,1,10),
(107,1,50),
(120,1,10),
(122,1,3),
(130,1,3),
(132,1,3),
(133,1,3),
(141,1,3),
(143,1,3),
(144,1,3),
(145,1,3),
(177,1,50),
(238,1,200),
(393,1,200),
(398,1,200),
(404,1,200),
(445,1,10),
(448,1,10),
(450,1,50),
(452,1,10),
(454,1,10),
(458,1,10),
(467,1,10),
(483,1,25),
(497,1,3),
(517,1,3),
(519,1,3),
(535,1,3),
(561,1,3),
(562,1,3),
(563,1,3),
(564,1,1000),
(565,1,1000),
(600,4,5),
(601,4,5),
(612,4,5),
(638,1,10),
(642,1,200),
(643,1,200),
(654,1,10),
(655,1,10),
(682,1,3),
(705,1,3),
(711,1,10),
(764,1,3),
(802,1,3),
(809,1,3),
(810,1,10),
(839,1,10),
(847,1,3),
(849,1,3),
(850,1,3),
(851,1,3),
(852,1,3),
(853,1,3),
(854,1,3),
(910,1,3),
(996,1,10),
(999,1,50),
(1002,1,3),
(1003,1,3),
(1004,1,3),
(1005,1,3),
(1016,1,20),
(1035,1,3),
(1065,1,50),
(1069,1,3),
(1070,1,3),
(1071,1,3),
(1072,1,3),
(1073,1,3),
(1074,1,3),
(1075,1,3),
(1077,1,3),
(1131,1,50),
(1133,1,20),
(1139,1,10),
(1142,1,10),
(1143,1,10),
(1144,1,10),
(1145,1,10),
(1153,1,50),
(1162,1,20),
(1179,1,10),
(1192,1,200),
(1193,1,10),
(1203,1,150),
(1204,1,10),
(1210,1,3),
(1217,1,200),
(1218,1,200),
(1241,1,10),
(1259,1,3),
(1264,1,3),
(1272,1,10),
(1282,1,20);
/*!40000 ALTER TABLE `antidos_opcode_policies` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-29 17:53:33
