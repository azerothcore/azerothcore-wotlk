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
-- Table structure for table `exploration_basexp`
--

DROP TABLE IF EXISTS `exploration_basexp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exploration_basexp` (
  `level` tinyint unsigned NOT NULL DEFAULT '0',
  `basexp` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Exploration System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exploration_basexp`
--

LOCK TABLES `exploration_basexp` WRITE;
/*!40000 ALTER TABLE `exploration_basexp` DISABLE KEYS */;
INSERT INTO `exploration_basexp` VALUES
(0,0),
(1,5),
(2,15),
(3,25),
(4,35),
(5,45),
(6,55),
(7,65),
(8,70),
(9,80),
(10,85),
(11,90),
(12,90),
(13,90),
(14,100),
(15,105),
(16,115),
(17,125),
(18,135),
(19,145),
(20,155),
(21,165),
(22,175),
(23,185),
(24,195),
(25,200),
(26,210),
(27,220),
(28,230),
(29,240),
(30,245),
(31,250),
(32,255),
(33,265),
(34,270),
(35,275),
(36,280),
(37,285),
(38,285),
(39,300),
(40,315),
(41,330),
(42,345),
(43,360),
(44,375),
(45,390),
(46,405),
(47,420),
(48,440),
(49,455),
(50,470),
(51,490),
(52,510),
(53,530),
(54,540),
(55,560),
(56,580),
(57,600),
(58,620),
(59,640),
(60,660),
(61,970),
(62,1000),
(63,1050),
(64,1080),
(65,1100),
(66,1130),
(67,1160),
(68,1200),
(69,1230),
(70,1300),
(71,1330),
(72,1370),
(73,1410),
(74,1440),
(75,1470),
(76,1510),
(77,1530),
(78,1600),
(79,1630);
/*!40000 ALTER TABLE `exploration_basexp` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-29 17:53:53
