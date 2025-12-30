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
-- Table structure for table `talent_dbc`
--

DROP TABLE IF EXISTS `talent_dbc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `talent_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `TabID` int NOT NULL DEFAULT '0',
  `TierID` int NOT NULL DEFAULT '0',
  `ColumnIndex` int NOT NULL DEFAULT '0',
  `SpellRank_1` int NOT NULL DEFAULT '0',
  `SpellRank_2` int NOT NULL DEFAULT '0',
  `SpellRank_3` int NOT NULL DEFAULT '0',
  `SpellRank_4` int NOT NULL DEFAULT '0',
  `SpellRank_5` int NOT NULL DEFAULT '0',
  `SpellRank_6` int NOT NULL DEFAULT '0',
  `SpellRank_7` int NOT NULL DEFAULT '0',
  `SpellRank_8` int NOT NULL DEFAULT '0',
  `SpellRank_9` int NOT NULL DEFAULT '0',
  `PrereqTalent_1` int NOT NULL DEFAULT '0',
  `PrereqTalent_2` int NOT NULL DEFAULT '0',
  `PrereqTalent_3` int NOT NULL DEFAULT '0',
  `PrereqRank_1` int NOT NULL DEFAULT '0',
  `PrereqRank_2` int NOT NULL DEFAULT '0',
  `PrereqRank_3` int NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `RequiredSpellID` int NOT NULL DEFAULT '0',
  `CategoryMask_1` int NOT NULL DEFAULT '0',
  `CategoryMask_2` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `talent_dbc`
--

LOCK TABLES `talent_dbc` WRITE;
/*!40000 ALTER TABLE `talent_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `talent_dbc` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-29 17:54:43
