/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `gm_survey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gm_survey` 
(
  `surveyId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `guid` int(10) unsigned NOT NULL DEFAULT '0',
  `mainSurvey` int(10) unsigned NOT NULL DEFAULT '0',
  `comment` longtext NOT NULL,
  `createTime` int(10) unsigned NOT NULL DEFAULT '0',
  `maxMMR` smallint(5) NOT NULL,
  PRIMARY KEY (`surveyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `gm_survey` WRITE;
/*!40000 ALTER TABLE `gm_survey` DISABLE KEYS */;
/*!40000 ALTER TABLE `gm_survey` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

