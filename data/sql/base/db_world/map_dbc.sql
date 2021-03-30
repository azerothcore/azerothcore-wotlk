/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `map_dbc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = UTF8MB4 */;
CREATE TABLE `map_dbc` 
(
  `ID` INT NOT NULL DEFAULT 0,
  `Directory` varchar(100) DEFAULT NULL,
  `InstanceType` INT NOT NULL DEFAULT 0,
  `Flags` INT NOT NULL DEFAULT 0,
  `PVP` INT NOT NULL DEFAULT 0,
  `MapName_Lang_enUS` varchar(100) DEFAULT NULL,
  `MapName_Lang_enGB` varchar(100) DEFAULT NULL,
  `MapName_Lang_koKR` varchar(100) DEFAULT NULL,
  `MapName_Lang_frFR` varchar(100) DEFAULT NULL,
  `MapName_Lang_deDE` varchar(100) DEFAULT NULL,
  `MapName_Lang_enCN` varchar(100) DEFAULT NULL,
  `MapName_Lang_zhCN` varchar(100) DEFAULT NULL,
  `MapName_Lang_enTW` varchar(100) DEFAULT NULL,
  `MapName_Lang_zhTW` varchar(100) DEFAULT NULL,
  `MapName_Lang_esES` varchar(100) DEFAULT NULL,
  `MapName_Lang_esMX` varchar(100) DEFAULT NULL,
  `MapName_Lang_ruRU` varchar(100) DEFAULT NULL,
  `MapName_Lang_ptPT` varchar(100) DEFAULT NULL,
  `MapName_Lang_ptBR` varchar(100) DEFAULT NULL,
  `MapName_Lang_itIT` varchar(100) DEFAULT NULL,
  `MapName_Lang_Unk` varchar(100) DEFAULT NULL,
  `MapName_Lang_Mask` INT unsigned NOT NULL DEFAULT 0,
  `AreaTableID` INT NOT NULL DEFAULT 0,
  `MapDescription0_Lang_enUS` TEXT(500) DEFAULT NULL,
  `MapDescription0_Lang_enGB` TEXT(500) DEFAULT NULL,
  `MapDescription0_Lang_koKR` TEXT(500) DEFAULT NULL,
  `MapDescription0_Lang_frFR` TEXT(500) DEFAULT NULL,
  `MapDescription0_Lang_deDE` TEXT(500) DEFAULT NULL,
  `MapDescription0_Lang_enCN` TEXT(500) DEFAULT NULL,
  `MapDescription0_Lang_zhCN` TEXT(500) DEFAULT NULL,
  `MapDescription0_Lang_enTW` TEXT(500) DEFAULT NULL,
  `MapDescription0_Lang_zhTW` TEXT(500) DEFAULT NULL,
  `MapDescription0_Lang_esES` TEXT(500) DEFAULT NULL,
  `MapDescription0_Lang_esMX` TEXT(500) DEFAULT NULL,
  `MapDescription0_Lang_ruRU` TEXT(500) DEFAULT NULL,
  `MapDescription0_Lang_ptPT` TEXT(500) DEFAULT NULL,
  `MapDescription0_Lang_ptBR` TEXT(500) DEFAULT NULL,
  `MapDescription0_Lang_itIT` TEXT(500) DEFAULT NULL,
  `MapDescription0_Lang_Unk` varchar(100) DEFAULT NULL,
  `MapDescription0_Lang_Mask` INT unsigned NOT NULL DEFAULT 0,
  `MapDescription1_Lang_enUS` TEXT(500) DEFAULT NULL,
  `MapDescription1_Lang_enGB` TEXT(500) DEFAULT NULL,
  `MapDescription1_Lang_koKR` TEXT(500) DEFAULT NULL,
  `MapDescription1_Lang_frFR` TEXT(500) DEFAULT NULL,
  `MapDescription1_Lang_deDE` TEXT(500) DEFAULT NULL,
  `MapDescription1_Lang_enCN` TEXT(500) DEFAULT NULL,
  `MapDescription1_Lang_zhCN` TEXT(500) DEFAULT NULL,
  `MapDescription1_Lang_enTW` TEXT(500) DEFAULT NULL,
  `MapDescription1_Lang_zhTW` TEXT(500) DEFAULT NULL,
  `MapDescription1_Lang_esES` TEXT(500) DEFAULT NULL,
  `MapDescription1_Lang_esMX` TEXT(500) DEFAULT NULL,
  `MapDescription1_Lang_ruRU` TEXT(500) DEFAULT NULL,
  `MapDescription1_Lang_ptPT` TEXT(500) DEFAULT NULL,
  `MapDescription1_Lang_ptBR` TEXT(500) DEFAULT NULL,
  `MapDescription1_Lang_itIT` TEXT(500) DEFAULT NULL,
  `MapDescription1_Lang_Unk` varchar(100) DEFAULT NULL,
  `MapDescription1_Lang_Mask` INT unsigned NOT NULL DEFAULT 0,
  `LoadingScreenID` INT NOT NULL DEFAULT 0,
  `MinimapIconScale` float NOT NULL DEFAULT 0,
  `CorpseMapID` INT NOT NULL DEFAULT 0,
  `CorpseX` float NOT NULL DEFAULT 0,
  `CorpseY` float NOT NULL DEFAULT 0,
  `TimeOfDayOverride` INT NOT NULL DEFAULT 0,
  `ExpansionID` INT NOT NULL DEFAULT 0,
  `RaidOffset` INT NOT NULL DEFAULT 0,
  `MaxPlayers` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=UTF8MB4;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `map_dbc` WRITE;
/*!40000 ALTER TABLE `map_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `map_dbc` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

