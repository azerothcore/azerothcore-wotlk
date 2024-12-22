-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: acore_characters
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
-- Table structure for table `character_equipmentsets`
--

DROP TABLE IF EXISTS `character_equipmentsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `character_equipmentsets` (
  `guid` int NOT NULL DEFAULT '0',
  `setguid` bigint NOT NULL AUTO_INCREMENT,
  `setindex` tinyint unsigned NOT NULL DEFAULT '0',
  `name` varchar(31) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `iconname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ignore_mask` int unsigned NOT NULL DEFAULT '0',
  `item0` int unsigned NOT NULL DEFAULT '0',
  `item1` int unsigned NOT NULL DEFAULT '0',
  `item2` int unsigned NOT NULL DEFAULT '0',
  `item3` int unsigned NOT NULL DEFAULT '0',
  `item4` int unsigned NOT NULL DEFAULT '0',
  `item5` int unsigned NOT NULL DEFAULT '0',
  `item6` int unsigned NOT NULL DEFAULT '0',
  `item7` int unsigned NOT NULL DEFAULT '0',
  `item8` int unsigned NOT NULL DEFAULT '0',
  `item9` int unsigned NOT NULL DEFAULT '0',
  `item10` int unsigned NOT NULL DEFAULT '0',
  `item11` int unsigned NOT NULL DEFAULT '0',
  `item12` int unsigned NOT NULL DEFAULT '0',
  `item13` int unsigned NOT NULL DEFAULT '0',
  `item14` int unsigned NOT NULL DEFAULT '0',
  `item15` int unsigned NOT NULL DEFAULT '0',
  `item16` int unsigned NOT NULL DEFAULT '0',
  `item17` int unsigned NOT NULL DEFAULT '0',
  `item18` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`setguid`),

  UNIQUE KEY `idx_set` (`guid`,`setguid`,`setindex`),

  KEY `Idx_setindex` (`setindex`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `character_equipmentsets`
--

LOCK TABLES `character_equipmentsets` WRITE;
/*!40000 ALTER TABLE `character_equipmentsets` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_equipmentsets` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-17 22:33:01

