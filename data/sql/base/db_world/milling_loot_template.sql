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
-- Table structure for table `milling_loot_template`
--

DROP TABLE IF EXISTS `milling_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `milling_loot_template` (
  `Entry` int unsigned NOT NULL DEFAULT '0',
  `Item` int unsigned NOT NULL DEFAULT '0',
  `Reference` int NOT NULL DEFAULT '0',
  `Chance` float NOT NULL DEFAULT '100',
  `QuestRequired` tinyint NOT NULL DEFAULT '0',
  `LootMode` smallint unsigned NOT NULL DEFAULT '1',
  `GroupId` tinyint unsigned NOT NULL DEFAULT '0',
  `MinCount` tinyint unsigned NOT NULL DEFAULT '1',
  `MaxCount` tinyint unsigned NOT NULL DEFAULT '1',
  `Comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Entry`,`Item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `milling_loot_template`
--

LOCK TABLES `milling_loot_template` WRITE;
/*!40000 ALTER TABLE `milling_loot_template` DISABLE KEYS */;
INSERT INTO `milling_loot_template` VALUES
(765,11900,11900,100,0,1,0,1,1,'(ReferenceTable)'),
(785,11901,11901,100,0,1,0,1,1,'(ReferenceTable)'),
(2447,11900,11900,100,0,1,0,1,1,'(ReferenceTable)'),
(2449,11900,11900,100,0,1,0,1,1,'(ReferenceTable)'),
(2450,11902,11902,100,0,1,0,1,1,'(ReferenceTable)'),
(2452,11902,11902,100,0,1,0,1,1,'(ReferenceTable)'),
(2453,11903,11903,100,0,1,0,1,1,'(ReferenceTable)'),
(3355,11904,11904,100,0,1,0,1,1,'(ReferenceTable)'),
(3356,11905,11905,100,0,1,0,1,1,'(ReferenceTable)'),
(3357,11905,11905,100,0,1,0,1,1,'(ReferenceTable)'),
(3358,11907,11907,100,0,1,0,1,1,'(ReferenceTable)'),
(3369,11904,11904,100,0,1,0,1,1,'(ReferenceTable)'),
(3818,11906,11906,100,0,1,0,1,1,'(ReferenceTable)'),
(3819,11907,11907,100,0,1,0,1,1,'(ReferenceTable)'),
(3820,11903,11903,100,0,1,0,1,1,'(ReferenceTable)'),
(3821,11906,11906,100,0,1,0,1,1,'(ReferenceTable)'),
(4625,11908,11908,100,0,1,0,1,1,'(ReferenceTable)'),
(8831,11908,11908,100,0,1,0,1,1,'(ReferenceTable)'),
(8836,11908,11908,100,0,1,0,1,1,'(ReferenceTable)'),
(8838,11908,11908,100,0,1,0,1,1,'(ReferenceTable)'),
(8839,11909,11909,100,0,1,0,1,1,'(ReferenceTable)'),
(8845,11909,11909,100,0,1,0,1,1,'(ReferenceTable)'),
(8846,11909,11909,100,0,1,0,1,1,'(ReferenceTable)'),
(13463,11910,11910,100,0,1,0,1,1,'(ReferenceTable)'),
(13464,11910,11910,100,0,1,0,1,1,'(ReferenceTable)'),
(13465,11911,11911,100,0,1,0,1,1,'(ReferenceTable)'),
(13466,11911,11911,100,0,1,0,1,1,'(ReferenceTable)'),
(13467,11911,11911,100,0,1,0,1,1,'(ReferenceTable)'),
(22785,11913,11913,100,0,1,0,1,1,'(ReferenceTable)'),
(22786,11912,11912,100,0,1,0,1,1,'(ReferenceTable)'),
(22787,11912,11912,100,0,1,0,1,1,'(ReferenceTable)'),
(22789,11912,11912,100,0,1,0,1,1,'(ReferenceTable)'),
(22790,11914,11914,100,0,1,0,1,1,'(ReferenceTable)'),
(22791,11914,11914,100,0,1,0,1,1,'(ReferenceTable)'),
(22792,11914,11914,100,0,1,0,1,1,'(ReferenceTable)'),
(22793,11914,11914,100,0,1,0,1,1,'(ReferenceTable)'),
(36901,11916,11916,100,0,1,0,1,1,'(ReferenceTable)'),
(36903,11918,11918,100,0,1,0,1,1,'(ReferenceTable)'),
(36904,11916,11916,100,0,1,0,1,1,'(ReferenceTable)'),
(36905,11917,11917,100,0,1,0,1,1,'(ReferenceTable)'),
(36906,11917,11917,100,0,1,0,1,1,'(ReferenceTable)'),
(36907,11915,11915,100,0,1,0,1,1,'(ReferenceTable)'),
(37921,11916,11916,100,0,1,0,1,1,'(ReferenceTable)'),
(39969,11915,11915,100,0,1,0,1,1,'(ReferenceTable)'),
(39970,11915,11915,100,0,1,0,1,1,'(ReferenceTable)');
/*!40000 ALTER TABLE `milling_loot_template` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-29 17:54:13
