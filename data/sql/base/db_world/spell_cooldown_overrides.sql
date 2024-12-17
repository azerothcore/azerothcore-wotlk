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
-- Table structure for table `spell_cooldown_overrides`
--

DROP TABLE IF EXISTS `spell_cooldown_overrides`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spell_cooldown_overrides` (
  `Id` int unsigned NOT NULL,
  `RecoveryTime` int unsigned NOT NULL DEFAULT '0',
  `CategoryRecoveryTime` int unsigned NOT NULL DEFAULT '0',
  `StartRecoveryTime` int unsigned NOT NULL DEFAULT '0',
  `StartRecoveryCategory` int unsigned NOT NULL DEFAULT '0',
  `Comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spell_cooldown_overrides`
--

LOCK TABLES `spell_cooldown_overrides` WRITE;
/*!40000 ALTER TABLE `spell_cooldown_overrides` DISABLE KEYS */;
INSERT INTO `spell_cooldown_overrides` VALUES
(31626,5000,5000,0,0,'Shadowy Necromancer - Unholy Frenzy'),
(34019,60000,60000,0,0,'Bleeding Hollow Necrolyte - Raise Dead'),
(37118,8000,8000,0,0,'Tempest-Smith - Shell Shock'),
(37455,20000,20000,0,0,NULL),
(37456,20000,20000,0,0,NULL),
(37471,15000,15000,0,0,'Karazhan Chest - Heroism'),
(37472,15000,15000,0,0,'Karazhan Chest - Bloodlust'),
(37920,30000,30000,0,0,'Fel Reaver Sentinel - Turbo Boost'),
(38006,10000,10000,0,0,'Fel Reaver Sentinel - World Breaker'),
(38052,15000,15000,0,0,'Fel Reaver Sentinel - Sonic Boom'),
(38055,10000,10000,0,0,'Fel Reaver Sentinel - Destroy Deathforged Infernal');
/*!40000 ALTER TABLE `spell_cooldown_overrides` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-17 22:34:38

