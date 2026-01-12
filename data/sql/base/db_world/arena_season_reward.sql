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
-- Table structure for table `arena_season_reward`
--

DROP TABLE IF EXISTS `arena_season_reward`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `arena_season_reward` (
  `group_id` int NOT NULL COMMENT 'id from arena_season_reward_group table',
  `type` enum('achievement','item') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'achievement',
  `entry` int unsigned NOT NULL COMMENT 'For item type - item entry, for achievement - achevement id.',
  PRIMARY KEY (`group_id`,`type`,`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arena_season_reward`
--

LOCK TABLES `arena_season_reward` WRITE;
/*!40000 ALTER TABLE `arena_season_reward` DISABLE KEYS */;
INSERT INTO `arena_season_reward` VALUES
(1,'achievement',4599),
(2,'achievement',2091),
(2,'item',50435),
(3,'achievement',2092),
(4,'achievement',2093),
(5,'achievement',2090),
(6,'achievement',3758),
(7,'achievement',2091),
(7,'item',47840),
(8,'achievement',2092),
(9,'achievement',2093),
(10,'achievement',2090),
(11,'achievement',3436),
(12,'achievement',2091),
(12,'item',46171),
(13,'achievement',2092),
(14,'achievement',2093),
(15,'achievement',2090),
(16,'achievement',3336),
(17,'achievement',2091),
(17,'item',46708),
(18,'achievement',2092),
(19,'achievement',2093),
(20,'achievement',2090),
(21,'achievement',420),
(22,'achievement',2091),
(22,'item',43516),
(23,'achievement',2092),
(24,'achievement',2093),
(25,'achievement',2090),
(26,'achievement',419),
(27,'achievement',2091),
(27,'item',37676),
(28,'achievement',2092),
(29,'achievement',2093),
(30,'achievement',2090),
(31,'achievement',418),
(32,'achievement',2091),
(32,'item',34092),
(33,'achievement',2092),
(34,'achievement',2093),
(35,'achievement',2090),
(36,'achievement',2091),
(36,'item',30609),
(37,'achievement',2092),
(38,'achievement',2093),
(39,'achievement',2090);
/*!40000 ALTER TABLE `arena_season_reward` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-29 17:53:36
