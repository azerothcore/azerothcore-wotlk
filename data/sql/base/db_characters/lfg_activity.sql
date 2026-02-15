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
-- Table structure for table `lfg_activity`
--

DROP TABLE IF EXISTS `lfg_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lfg_activity` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier',
  `playerGuid` int unsigned NOT NULL COMMENT 'Player GUID',
  `eventType` tinyint unsigned NOT NULL COMMENT 'Event type: 1=joined, 2=refused, 3=left, 4=kicked, 5=disconnected',
  `dungeonId` int unsigned NOT NULL COMMENT 'Dungeon/Raid ID',
  `groupGuid` int unsigned DEFAULT NULL COMMENT 'Group GUID if applicable',
  `timestamp` int unsigned NOT NULL COMMENT 'Unix timestamp of the event',
  PRIMARY KEY (`id`),
  KEY `idx_player` (`playerGuid`),
  KEY `idx_timestamp` (`timestamp`),
  KEY `idx_dungeon` (`dungeonId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='LFG Activity Tracking';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lfg_activity`
--

LOCK TABLES `lfg_activity` WRITE;
/*!40000 ALTER TABLE `lfg_activity` DISABLE KEYS */;
/*!40000 ALTER TABLE `lfg_activity` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-15 12:08:03
