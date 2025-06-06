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
-- Table structure for table `durabilitycosts_dbc`
--

DROP TABLE IF EXISTS `durabilitycosts_dbc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `durabilitycosts_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_1` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_2` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_3` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_4` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_5` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_6` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_7` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_8` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_9` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_10` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_11` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_12` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_13` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_14` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_15` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_16` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_17` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_18` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_19` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_20` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_21` int NOT NULL DEFAULT '0',
  `ArmorSubClassCost_1` int NOT NULL DEFAULT '0',
  `ArmorSubClassCost_2` int NOT NULL DEFAULT '0',
  `ArmorSubClassCost_3` int NOT NULL DEFAULT '0',
  `ArmorSubClassCost_4` int NOT NULL DEFAULT '0',
  `ArmorSubClassCost_5` int NOT NULL DEFAULT '0',
  `ArmorSubClassCost_6` int NOT NULL DEFAULT '0',
  `ArmorSubClassCost_7` int NOT NULL DEFAULT '0',
  `ArmorSubClassCost_8` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `durabilitycosts_dbc`
--

LOCK TABLES `durabilitycosts_dbc` WRITE;
/*!40000 ALTER TABLE `durabilitycosts_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `durabilitycosts_dbc` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-17 22:33:44

