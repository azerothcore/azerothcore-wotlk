/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `mapdifficulty_dbc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = UTF8MB4 */;
CREATE TABLE `mapdifficulty_dbc` 
(
  `ID` INT NOT NULL DEFAULT 0,
  `MapID` INT NOT NULL DEFAULT 0,
  `Difficulty` INT NOT NULL DEFAULT 0,
  `Message_Lang_enUS` varchar(200) DEFAULT NULL,
  `Message_Lang_enGB` varchar(200) DEFAULT NULL,
  `Message_Lang_koKR` varchar(200) DEFAULT NULL,
  `Message_Lang_frFR` varchar(200) DEFAULT NULL,
  `Message_Lang_deDE` varchar(200) DEFAULT NULL,
  `Message_Lang_enCN` varchar(200) DEFAULT NULL,
  `Message_Lang_zhCN` varchar(200) DEFAULT NULL,
  `Message_Lang_enTW` varchar(200) DEFAULT NULL,
  `Message_Lang_zhTW` varchar(200) DEFAULT NULL,
  `Message_Lang_esES` varchar(200) DEFAULT NULL,
  `Message_Lang_esMX` varchar(200) DEFAULT NULL,
  `Message_Lang_ruRU` varchar(200) DEFAULT NULL,
  `Message_Lang_ptPT` varchar(200) DEFAULT NULL,
  `Message_Lang_ptBR` varchar(200) DEFAULT NULL,
  `Message_Lang_itIT` varchar(200) DEFAULT NULL,
  `Message_Lang_Unk` varchar(100) DEFAULT NULL,
  `Message_Lang_Mask` INT unsigned NOT NULL DEFAULT 0,
  `RaidDuration` INT NOT NULL DEFAULT 0,
  `MaxPlayers` INT NOT NULL DEFAULT 0,
  `Difficultystring` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=UTF8MB4;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `mapdifficulty_dbc` WRITE;
/*!40000 ALTER TABLE `mapdifficulty_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `mapdifficulty_dbc` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

