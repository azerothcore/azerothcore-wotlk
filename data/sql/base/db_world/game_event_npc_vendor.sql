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
-- Table structure for table `game_event_npc_vendor`
--

DROP TABLE IF EXISTS `game_event_npc_vendor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game_event_npc_vendor` (
  `eventEntry` tinyint NOT NULL COMMENT 'Entry of the game event.',
  `guid` int unsigned NOT NULL DEFAULT '0',
  `slot` smallint NOT NULL DEFAULT '0',
  `item` int unsigned NOT NULL DEFAULT '0',
  `maxcount` int unsigned NOT NULL DEFAULT '0',
  `incrtime` int unsigned NOT NULL DEFAULT '0',
  `ExtendedCost` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`eventEntry`,`guid`,`item`) USING BTREE,
  KEY `slot` (`slot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_event_npc_vendor`
--

LOCK TABLES `game_event_npc_vendor` WRITE;
/*!40000 ALTER TABLE `game_event_npc_vendor` DISABLE KEYS */;
INSERT INTO `game_event_npc_vendor` VALUES
(10,97984,0,46693,0,0,0),
(10,99369,0,46693,0,0,0),
(17,7,0,23160,0,0,0),
(17,7,0,23161,0,0,0),
(17,1803,0,23160,0,0,0),
(17,1803,0,23161,0,0,0),
(17,26771,0,23160,0,0,0),
(17,26771,0,23161,0,0,0),
(17,38112,0,23160,0,0,0),
(17,38112,0,23161,0,0,0),
(17,46320,0,23160,0,0,0),
(17,46320,0,23161,0,0,0),
(17,208240,0,23160,0,0,0),
(17,208240,0,23161,0,0,0);
/*!40000 ALTER TABLE `game_event_npc_vendor` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-17 22:33:48

