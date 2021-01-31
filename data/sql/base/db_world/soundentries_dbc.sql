/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `soundentries_dbc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `soundentries_dbc` 
(
  `ID` int(11) NOT NULL DEFAULT 0,
  `SoundType` int(11) NOT NULL DEFAULT 0,
  `Name` varchar(100) DEFAULT NULL,
  `File_1` varchar(100) DEFAULT NULL,
  `File_2` varchar(100) DEFAULT NULL,
  `File_3` varchar(100) DEFAULT NULL,
  `File_4` varchar(100) DEFAULT NULL,
  `File_5` varchar(100) DEFAULT NULL,
  `File_6` varchar(100) DEFAULT NULL,
  `File_7` varchar(100) DEFAULT NULL,
  `File_8` varchar(100) DEFAULT NULL,
  `File_9` varchar(100) DEFAULT NULL,
  `File_10` varchar(100) DEFAULT NULL,
  `Freq_1` int(11) NOT NULL DEFAULT 0,
  `Freq_2` int(11) NOT NULL DEFAULT 0,
  `Freq_3` int(11) NOT NULL DEFAULT 0,
  `Freq_4` int(11) NOT NULL DEFAULT 0,
  `Freq_5` int(11) NOT NULL DEFAULT 0,
  `Freq_6` int(11) NOT NULL DEFAULT 0,
  `Freq_7` int(11) NOT NULL DEFAULT 0,
  `Freq_8` int(11) NOT NULL DEFAULT 0,
  `Freq_9` int(11) NOT NULL DEFAULT 0,
  `Freq_10` int(11) NOT NULL DEFAULT 0,
  `DirectoryBase` varchar(100) DEFAULT NULL,
  `Volumefloat` float NOT NULL DEFAULT 0,
  `Flags` int(11) NOT NULL DEFAULT 0,
  `MinDistance` float NOT NULL DEFAULT 0,
  `DistanceCutoff` float NOT NULL DEFAULT 0,
  `EAXDef` int(11) NOT NULL DEFAULT 0,
  `SoundEntriesAdvancedID` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `soundentries_dbc` WRITE;
/*!40000 ALTER TABLE `soundentries_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `soundentries_dbc` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

