/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `mailtemplate_dbc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = UTF8MB4 */;
CREATE TABLE `mailtemplate_dbc` 
(
  `ID` INT NOT NULL DEFAULT 0,
  `Subject_Lang_enUS` varchar(100) DEFAULT NULL,
  `Subject_Lang_enGB` varchar(100) DEFAULT NULL,
  `Subject_Lang_koKR` varchar(100) DEFAULT NULL,
  `Subject_Lang_frFR` varchar(100) DEFAULT NULL,
  `Subject_Lang_deDE` varchar(100) DEFAULT NULL,
  `Subject_Lang_enCN` varchar(100) DEFAULT NULL,
  `Subject_Lang_zhCN` varchar(100) DEFAULT NULL,
  `Subject_Lang_enTW` varchar(100) DEFAULT NULL,
  `Subject_Lang_zhTW` varchar(100) DEFAULT NULL,
  `Subject_Lang_esES` varchar(100) DEFAULT NULL,
  `Subject_Lang_esMX` varchar(100) DEFAULT NULL,
  `Subject_Lang_ruRU` varchar(100) DEFAULT NULL,
  `Subject_Lang_ptPT` varchar(100) DEFAULT NULL,
  `Subject_Lang_ptBR` varchar(100) DEFAULT NULL,
  `Subject_Lang_itIT` varchar(100) DEFAULT NULL,
  `Subject_Lang_Unk` varchar(100) DEFAULT NULL,
  `Subject_Lang_Mask` INT unsigned NOT NULL DEFAULT 0,
  `Body_Lang_enUS` varchar(500) DEFAULT NULL,
  `Body_Lang_enGB` varchar(500) DEFAULT NULL,
  `Body_Lang_koKR` varchar(500) DEFAULT NULL,
  `Body_Lang_frFR` varchar(500) DEFAULT NULL,
  `Body_Lang_deDE` varchar(500) DEFAULT NULL,
  `Body_Lang_enCN` varchar(500) DEFAULT NULL,
  `Body_Lang_zhCN` varchar(500) DEFAULT NULL,
  `Body_Lang_enTW` varchar(500) DEFAULT NULL,
  `Body_Lang_zhTW` varchar(500) DEFAULT NULL,
  `Body_Lang_esES` varchar(500) DEFAULT NULL,
  `Body_Lang_esMX` varchar(500) DEFAULT NULL,
  `Body_Lang_ruRU` varchar(500) DEFAULT NULL,
  `Body_Lang_ptPT` varchar(500) DEFAULT NULL,
  `Body_Lang_ptBR` varchar(500) DEFAULT NULL,
  `Body_Lang_itIT` varchar(500) DEFAULT NULL,
  `Body_Lang_Unk` varchar(100) DEFAULT NULL,
  `Body_Lang_Mask` INT unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=UTF8MB4;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `mailtemplate_dbc` WRITE;
/*!40000 ALTER TABLE `mailtemplate_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `mailtemplate_dbc` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

