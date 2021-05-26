/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `spellrange_dbc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = UTF8MB4 */;
CREATE TABLE `spellrange_dbc` 
(
  `ID` INT NOT NULL DEFAULT 0,
  `RangeMin_1` float NOT NULL DEFAULT 0,
  `RangeMin_2` float NOT NULL DEFAULT 0,
  `RangeMax_1` float NOT NULL DEFAULT 0,
  `RangeMax_2` float NOT NULL DEFAULT 0,
  `Flags` INT NOT NULL DEFAULT 0,
  `DisplayName_Lang_enUS` text DEFAULT NULL,
  `DisplayName_Lang_enGB` text DEFAULT NULL,
  `DisplayName_Lang_koKR` text DEFAULT NULL,
  `DisplayName_Lang_frFR` text DEFAULT NULL,
  `DisplayName_Lang_deDE` text DEFAULT NULL,
  `DisplayName_Lang_enCN` text DEFAULT NULL,
  `DisplayName_Lang_zhCN` text DEFAULT NULL,
  `DisplayName_Lang_enTW` text DEFAULT NULL,
  `DisplayName_Lang_zhTW` text DEFAULT NULL,
  `DisplayName_Lang_esES` text DEFAULT NULL,
  `DisplayName_Lang_esMX` text DEFAULT NULL,
  `DisplayName_Lang_ruRU` text DEFAULT NULL,
  `DisplayName_Lang_ptPT` text DEFAULT NULL,
  `DisplayName_Lang_ptBR` text DEFAULT NULL,
  `DisplayName_Lang_itIT` text DEFAULT NULL,
  `DisplayName_Lang_Unk` text DEFAULT NULL,
  `DisplayName_Lang_Mask` INT unsigned NOT NULL DEFAULT 0,
  `DisplayNameShort_Lang_enUS` text DEFAULT NULL,
  `DisplayNameShort_Lang_enGB` text DEFAULT NULL,
  `DisplayNameShort_Lang_koKR` text DEFAULT NULL,
  `DisplayNameShort_Lang_frFR` text DEFAULT NULL,
  `DisplayNameShort_Lang_deDE` text DEFAULT NULL,
  `DisplayNameShort_Lang_enCN` text DEFAULT NULL,
  `DisplayNameShort_Lang_zhCN` text DEFAULT NULL,
  `DisplayNameShort_Lang_enTW` text DEFAULT NULL,
  `DisplayNameShort_Lang_zhTW` text DEFAULT NULL,
  `DisplayNameShort_Lang_esES` text DEFAULT NULL,
  `DisplayNameShort_Lang_esMX` text DEFAULT NULL,
  `DisplayNameShort_Lang_ruRU` text DEFAULT NULL,
  `DisplayNameShort_Lang_ptPT` text DEFAULT NULL,
  `DisplayNameShort_Lang_ptBR` text DEFAULT NULL,
  `DisplayNameShort_Lang_itIT` text DEFAULT NULL,
  `DisplayNameShort_Lang_Unk` text DEFAULT NULL,
  `DisplayNameShort_Lang_Mask` INT unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=UTF8MB4;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `spellrange_dbc` WRITE;
/*!40000 ALTER TABLE `spellrange_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `spellrange_dbc` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

