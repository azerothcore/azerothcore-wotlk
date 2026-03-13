-- MySQL dump 10.13  Distrib 8.4.3, for Win64 (x86_64)
--
-- Host: localhost    Database: acore_auth
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
-- Table structure for table `uptime`
--

DROP TABLE IF EXISTS `uptime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `uptime` (
  `realmid` int unsigned NOT NULL,
  `starttime` int unsigned NOT NULL DEFAULT '0',
  `uptime` int unsigned NOT NULL DEFAULT '0',
  `maxplayers` smallint unsigned NOT NULL DEFAULT '0',
  `revision` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'AzerothCore',
  PRIMARY KEY (`realmid`,`starttime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Uptime system';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uptime`
--

LOCK TABLES `uptime` WRITE;
/*!40000 ALTER TABLE `uptime` DISABLE KEYS */;
INSERT INTO `uptime` VALUES
(1,1721169877,0,0,'AzerothCore rev. bdf204f1eb0c 2024-07-16 16:28:59 +0000 (time-for-A-SQUASH branch) (Win64, RelWithDebInfo, Static)'),
(1,1734468956,0,0,'AzerothCore rev. 2923a4aa43d0 2024-12-17 12:28:46 -0300 (master branch) (Win64, RelWithDebInfo, Static)'),
(1,1734470333,0,0,'AzerothCore rev. 2923a4aa43d0 2024-12-17 12:28:46 -0300 (master branch) (Win64, RelWithDebInfo, Static)'),
(1,1734471110,0,0,'AzerothCore rev. 2923a4aa43d0 2024-12-17 12:28:46 -0300 (master branch) (Win64, RelWithDebInfo, Static)'),
(1,1752912822,0,0,'AzerothCore rev. 9415d1bef80d 2025-07-05 11:29:15 +0200 (whisper-something-something branch) (Win64, RelWithDebInfo, Static)'),
(1,1752913079,0,0,'AzerothCore rev. 9415d1bef80d 2025-07-05 11:29:15 +0200 (whisper-something-something branch) (Win64, RelWithDebInfo, Static)'),
(1,1752919589,0,0,'AzerothCore rev. 9415d1bef80d 2025-07-05 11:29:15 +0200 (whisper-something-something branch) (Win64, RelWithDebInfo, Static)'),
(1,1767027047,0,0,'AzerothCore rev. 10d105243f47 2025-12-29 17:44:37 +0100 (Last-DB-SQUASH-OF-2025-WOO-HOO-WOOP-WOOP branch) (Win64, RelWithDebInfo, Static)');
/*!40000 ALTER TABLE `uptime` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-29 17:55:20
