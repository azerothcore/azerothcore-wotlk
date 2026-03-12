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
-- Table structure for table `skill_fishing_base_level`
--

DROP TABLE IF EXISTS `skill_fishing_base_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skill_fishing_base_level` (
  `entry` int unsigned NOT NULL DEFAULT '0' COMMENT 'Area identifier',
  `skill` smallint NOT NULL DEFAULT '0' COMMENT 'Base skill level requirement',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Fishing system';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skill_fishing_base_level`
--

LOCK TABLES `skill_fishing_base_level` WRITE;
/*!40000 ALTER TABLE `skill_fishing_base_level` DISABLE KEYS */;
INSERT INTO `skill_fishing_base_level` VALUES
(1,-70),
(8,130),
(10,55),
(11,55),
(12,-70),
(14,-70),
(15,130),
(16,205),
(17,-20),
(28,205),
(33,130),
(36,130),
(38,-20),
(40,-20),
(41,330),
(44,55),
(45,130),
(46,330),
(47,205),
(65,380),
(85,-70),
(130,-20),
(139,330),
(141,-70),
(148,-20),
(215,-70),
(267,55),
(297,205),
(331,55),
(357,205),
(361,205),
(394,380),
(400,130),
(405,130),
(406,55),
(440,205),
(490,205),
(493,205),
(495,380),
(618,330),
(718,-20),
(719,-20),
(796,130),
(1112,330),
(1222,330),
(1227,330),
(1377,330),
(1417,205),
(1497,-20),
(1519,-20),
(1537,-20),
(1581,-20),
(1637,-20),
(1638,-20),
(1657,-20),
(1977,330),
(2017,330),
(2057,330),
(2100,205),
(2817,405),
(3140,330),
(3430,-70),
(3433,-20),
(3479,225),
(3483,280),
(3518,380),
(3519,355),
(3520,280),
(3521,305),
(3523,380),
(3524,-70),
(3525,-20),
(3537,380),
(3607,300),
(3614,395),
(3621,395),
(3625,280),
(3653,355),
(3656,355),
(3658,355),
(3690,405),
(3691,405),
(3692,405),
(3711,430),
(3805,330),
(3859,405),
(3979,480),
(4080,355),
(4197,430),
(4395,430),
(4656,430),
(4710,480),
(4722,430),
(4813,450);
/*!40000 ALTER TABLE `skill_fishing_base_level` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-29 17:54:32
