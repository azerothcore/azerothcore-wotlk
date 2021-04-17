/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `destructiblemodeldata_dbc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = UTF8MB4 */;
CREATE TABLE `destructiblemodeldata_dbc` 
(
  `ID` INT NOT NULL DEFAULT 0,
  `State0Wmo` INT NOT NULL DEFAULT 0,
  `State0DestructionDoodadSet` INT NOT NULL DEFAULT 0,
  `State0ImpactEffectDoodadSet` INT NOT NULL DEFAULT 0,
  `State0AmbientDoodadSet` INT NOT NULL DEFAULT 0,
  `State1Wmo` INT NOT NULL DEFAULT 0,
  `State1DestructionDoodadSet` INT NOT NULL DEFAULT 0,
  `State1ImpactEffectDoodadSet` INT NOT NULL DEFAULT 0,
  `State1AmbientDoodadSet` INT NOT NULL DEFAULT 0,
  `State2Wmo` INT NOT NULL DEFAULT 0,
  `State2DestructionDoodadSet` INT NOT NULL DEFAULT 0,
  `State2ImpactEffectDoodadSet` INT NOT NULL DEFAULT 0,
  `State2AmbientDoodadSet` INT NOT NULL DEFAULT 0,
  `State3Wmo` INT NOT NULL DEFAULT 0,
  `State3DestructionDoodadSet` INT NOT NULL DEFAULT 0,
  `State3ImpactEffectDoodadSet` INT NOT NULL DEFAULT 0,
  `State3AmbientDoodadSet` INT NOT NULL DEFAULT 0,
  `Field17` INT NOT NULL DEFAULT 0,
  `Field18` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=UTF8MB4;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `destructiblemodeldata_dbc` WRITE;
/*!40000 ALTER TABLE `destructiblemodeldata_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `destructiblemodeldata_dbc` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

