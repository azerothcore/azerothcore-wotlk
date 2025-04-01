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
-- Table structure for table `randproppoints_dbc`
--

DROP TABLE IF EXISTS `randproppoints_dbc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `randproppoints_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Epic_1` int NOT NULL DEFAULT '0',
  `Epic_2` int NOT NULL DEFAULT '0',
  `Epic_3` int NOT NULL DEFAULT '0',
  `Epic_4` int NOT NULL DEFAULT '0',
  `Epic_5` int NOT NULL DEFAULT '0',
  `Superior_1` int NOT NULL DEFAULT '0',
  `Superior_2` int NOT NULL DEFAULT '0',
  `Superior_3` int NOT NULL DEFAULT '0',
  `Superior_4` int NOT NULL DEFAULT '0',
  `Superior_5` int NOT NULL DEFAULT '0',
  `Good_1` int NOT NULL DEFAULT '0',
  `Good_2` int NOT NULL DEFAULT '0',
  `Good_3` int NOT NULL DEFAULT '0',
  `Good_4` int NOT NULL DEFAULT '0',
  `Good_5` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `randproppoints_dbc`
--

LOCK TABLES `randproppoints_dbc` WRITE;
/*!40000 ALTER TABLE `randproppoints_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `randproppoints_dbc` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-17 22:34:33

