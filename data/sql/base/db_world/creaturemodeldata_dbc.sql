/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `creaturemodeldata_dbc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = UTF8MB4 */;
CREATE TABLE `creaturemodeldata_dbc` 
(
  `ID` INT NOT NULL DEFAULT 0,
  `Flags` INT NOT NULL DEFAULT 0,
  `ModelName` varchar(100) DEFAULT NULL,
  `SizeClass` INT NOT NULL DEFAULT 0,
  `ModelScale` float NOT NULL DEFAULT 0,
  `BloodID` INT NOT NULL DEFAULT 0,
  `FootprintTextureID` INT NOT NULL DEFAULT 0,
  `FootprintTextureLength` float NOT NULL DEFAULT 0,
  `FootprintTextureWidth` float NOT NULL DEFAULT 0,
  `FootprintParticleScale` float NOT NULL DEFAULT 0,
  `FoleyMaterialID` INT NOT NULL DEFAULT 0,
  `FootstepShakeSize` INT NOT NULL DEFAULT 0,
  `DeathThudShakeSize` INT NOT NULL DEFAULT 0,
  `SoundID` INT NOT NULL DEFAULT 0,
  `CollisionWidth` float NOT NULL DEFAULT 0,
  `CollisionHeight` float NOT NULL DEFAULT 0,
  `MountHeight` float NOT NULL DEFAULT 0,
  `GeoBoxMinX` float NOT NULL DEFAULT 0,
  `GeoBoxMinY` float NOT NULL DEFAULT 0,
  `GeoBoxMinZ` float NOT NULL DEFAULT 0,
  `GeoBoxMaxX` float NOT NULL DEFAULT 0,
  `GeoBoxMaxY` float NOT NULL DEFAULT 0,
  `GeoBoxMaxZ` float NOT NULL DEFAULT 0,
  `WorldEffectScale` float NOT NULL DEFAULT 0,
  `AttachedEffectScale` float NOT NULL DEFAULT 0,
  `MissileCollisionRadius` float NOT NULL DEFAULT 0,
  `MissileCollisionPush` float NOT NULL DEFAULT 0,
  `MissileCollisionRaise` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=UTF8MB4;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `creaturemodeldata_dbc` WRITE;
/*!40000 ALTER TABLE `creaturemodeldata_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `creaturemodeldata_dbc` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

