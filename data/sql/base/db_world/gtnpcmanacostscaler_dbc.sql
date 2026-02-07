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
-- Table structure for table `gtnpcmanacostscaler_dbc`
--

DROP TABLE IF EXISTS `gtnpcmanacostscaler_dbc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gtnpcmanacostscaler_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Data` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gtnpcmanacostscaler_dbc`
--

LOCK TABLES `gtnpcmanacostscaler_dbc` WRITE;
/*!40000 ALTER TABLE `gtnpcmanacostscaler_dbc` DISABLE KEYS */;
INSERT INTO `gtnpcmanacostscaler_dbc` VALUES
(0,0.193),
(1,0.216),
(2,0.264),
(3,0.31),
(4,0.31),
(5,0.395),
(6,0.436),
(7,0.475),
(8,0.514),
(9,0.552),
(10,0.588),
(11,0.625),
(12,0.661),
(13,0.696),
(14,0.766),
(15,0.8),
(16,0.835),
(17,0.885),
(18,0.919),
(19,1),
(20,1.034),
(21,1.067),
(22,1.101),
(23,1.165),
(24,1.229),
(25,1.278),
(26,1.328),
(27,1.405),
(28,1.522),
(29,1.612),
(30,1.662),
(31,1.752),
(32,1.805),
(33,1.858),
(34,1.964),
(35,2.032),
(36,2.126),
(37,2.196),
(38,2.292),
(39,2.351),
(40,2.446),
(41,2.506),
(42,2.626),
(43,2.686),
(44,2.782),
(45,2.854),
(46,2.95),
(47,3.012),
(48,3.074),
(49,3.195),
(50,3.269),
(51,3.378),
(52,3.475),
(53,3.583),
(54,3.658),
(55,3.788),
(56,3.863),
(57,3.972),
(58,4.048),
(59,4.167),
(60,4.266),
(61,4.4),
(62,4.514),
(63,4.662),
(64,4.768),
(65,4.908),
(66,5.016),
(67,5.169),
(68,5.292),
(69,5.437),
(70,5.593),
(71,5.709),
(72,5.858),
(73,5.998),
(74,6.15),
(75,6.282),
(76,6.415),
(77,6.594),
(78,6.762),
(79,6.899),
(80,7.082),
(81,7.222),
(82,7.376),
(83,7.552),
(84,7.697),
(85,7.876),
(86,8.024),
(87,8.196),
(88,8.347),
(89,8.533),
(90,8.741),
(91,8.898),
(92,9.055),
(93,9.215),
(94,9.408),
(95,9.572),
(96,9.736),
(97,9.902),
(98,10.091),
(99,10.293);
/*!40000 ALTER TABLE `gtnpcmanacostscaler_dbc` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-29 17:54:04
