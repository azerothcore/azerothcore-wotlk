/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `destructiblemodeldata_dbc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `destructiblemodeldata_dbc` 
(
  `ID` int(11) NOT NULL DEFAULT 0,
  `State0Wmo` int(11) NOT NULL DEFAULT 0,
  `State0DestructionDoodadSet` int(11) NOT NULL DEFAULT 0,
  `State0ImpactEffectDoodadSet` int(11) NOT NULL DEFAULT 0,
  `State0AmbientDoodadSet` int(11) NOT NULL DEFAULT 0,
  `State1Wmo` int(11) NOT NULL DEFAULT 0,
  `State1DestructionDoodadSet` int(11) NOT NULL DEFAULT 0,
  `State1ImpactEffectDoodadSet` int(11) NOT NULL DEFAULT 0,
  `State1AmbientDoodadSet` int(11) NOT NULL DEFAULT 0,
  `State2Wmo` int(11) NOT NULL DEFAULT 0,
  `State2DestructionDoodadSet` int(11) NOT NULL DEFAULT 0,
  `State2ImpactEffectDoodadSet` int(11) NOT NULL DEFAULT 0,
  `State2AmbientDoodadSet` int(11) NOT NULL DEFAULT 0,
  `State3Wmo` int(11) NOT NULL DEFAULT 0,
  `State3DestructionDoodadSet` int(11) NOT NULL DEFAULT 0,
  `State3ImpactEffectDoodadSet` int(11) NOT NULL DEFAULT 0,
  `State3AmbientDoodadSet` int(11) NOT NULL DEFAULT 0,
  `Field17` int(11) NOT NULL DEFAULT 0,
  `Field18` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
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

