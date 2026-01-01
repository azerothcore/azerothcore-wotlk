-- MySQL dump 10.13  Distrib 8.4.3, for Win64 (x86_64)
--
-- Host: localhost    Database: acore_characters
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
-- Table structure for table `pvpstats_players`
--

DROP TABLE IF EXISTS `pvpstats_players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pvpstats_players` (
  `battleground_id` bigint unsigned NOT NULL,
  `character_guid` int unsigned NOT NULL,
  `winner` bit(1) NOT NULL,
  `score_killing_blows` int unsigned DEFAULT NULL,
  `score_deaths` int unsigned DEFAULT NULL,
  `score_honorable_kills` int unsigned DEFAULT NULL,
  `score_bonus_honor` int unsigned DEFAULT NULL,
  `score_damage_done` int unsigned DEFAULT NULL,
  `score_healing_done` int unsigned DEFAULT NULL,
  `attr_1` int unsigned DEFAULT '0',
  `attr_2` int unsigned DEFAULT '0',
  `attr_3` int unsigned DEFAULT '0',
  `attr_4` int unsigned DEFAULT '0',
  `attr_5` int unsigned DEFAULT '0',
  PRIMARY KEY (`battleground_id`,`character_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pvpstats_players`
--

LOCK TABLES `pvpstats_players` WRITE;
/*!40000 ALTER TABLE `pvpstats_players` DISABLE KEYS */;
/*!40000 ALTER TABLE `pvpstats_players` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-29 17:55:14
