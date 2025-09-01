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
-- Table structure for table `quest_greeting_locale`
--

DROP TABLE IF EXISTS `quest_greeting_locale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quest_greeting_locale` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `type` tinyint unsigned NOT NULL DEFAULT '0',
  `locale` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Greeting` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`ID`,`type`,`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quest_greeting_locale`
--

LOCK TABLES `quest_greeting_locale` WRITE;
/*!40000 ALTER TABLE `quest_greeting_locale` DISABLE KEYS */;
INSERT INTO `quest_greeting_locale` VALUES
(3390,0,'esES','Los Baldíos cuentan con una gran riqueza de sustancias de las que nosotros, los boticarios de Lordaeron, podemos aprovecharnos.',47014),
(3390,0,'esMX','Los Baldíos cuentan con una gran riqueza de sustancias de las que nosotros, los boticarios de Lordaeron, podemos aprovecharnos.',47014),
(5638,0,'esES','Tengo muchas cosas que hacer por aquí en Desolace, $N. Roetten quiere que recojamos algunos componentes para uno de nuestros clientes y buscar alguno de esos objetos perdidos.$b$bViéndote que estás aquí para ayudar. ¿Por qué no empezamos?',NULL),
(5638,0,'esMX','Tengo muchas cosas que hacer por aquí en Desolace, $N. Roetten quiere que recojamos algunos componentes para uno de nuestros clientes y buscar alguno de esos objetos perdidos.$b$bViéndote que estás aquí para ayudar. ¿Por qué no empezamos?',NULL),
(22292,0,'ruRU','Свет ещё не воссиял над Скеттисом.',0);
/*!40000 ALTER TABLE `quest_greeting_locale` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-17 22:00:26

