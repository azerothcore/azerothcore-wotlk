/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `itemdisplayinfo_dbc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = UTF8MB4 */;
CREATE TABLE `itemdisplayinfo_dbc` 
(
  `ID` INT NOT NULL DEFAULT 0,
  `ModelName_1` varchar(100) DEFAULT NULL,
  `ModelName_2` varchar(100) DEFAULT NULL,
  `ModelTexture_1` varchar(100) DEFAULT NULL,
  `ModelTexture_2` varchar(100) DEFAULT NULL,
  `InventoryIcon_1` varchar(100) DEFAULT NULL,
  `InventoryIcon_2` varchar(100) DEFAULT NULL,
  `GeosetGroup_1` INT NOT NULL DEFAULT 0,
  `GeosetGroup_2` INT NOT NULL DEFAULT 0,
  `GeosetGroup_3` INT NOT NULL DEFAULT 0,
  `Flags` INT NOT NULL DEFAULT 0,
  `SpellVisualID` INT NOT NULL DEFAULT 0,
  `GroupSoundIndex` INT NOT NULL DEFAULT 0,
  `HelmetGeosetVis_1` INT NOT NULL DEFAULT 0,
  `HelmetGeosetVis_2` INT NOT NULL DEFAULT 0,
  `Texture_1` varchar(100) DEFAULT NULL,
  `Texture_2` varchar(100) DEFAULT NULL,
  `Texture_3` varchar(100) DEFAULT NULL,
  `Texture_4` varchar(100) DEFAULT NULL,
  `Texture_5` varchar(100) DEFAULT NULL,
  `Texture_6` varchar(100) DEFAULT NULL,
  `Texture_7` varchar(100) DEFAULT NULL,
  `Texture_8` varchar(100) DEFAULT NULL,
  `ItemVisual` INT NOT NULL DEFAULT 0,
  `ParticleColorID` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=UTF8MB4;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `itemdisplayinfo_dbc` WRITE;
/*!40000 ALTER TABLE `itemdisplayinfo_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `itemdisplayinfo_dbc` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

