/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = UTF8MB4 */;
CREATE TABLE `groups` 
(
  `guid` INT unsigned NOT NULL,
  `leaderGuid` INT unsigned NOT NULL,
  `lootMethod` TINYINT unsigned NOT NULL,
  `looterGuid` INT unsigned NOT NULL,
  `lootThreshold` TINYINT unsigned NOT NULL,
  `icon1` INT unsigned NOT NULL,
  `icon2` INT unsigned NOT NULL,
  `icon3` INT unsigned NOT NULL,
  `icon4` INT unsigned NOT NULL,
  `icon5` INT unsigned NOT NULL,
  `icon6` INT unsigned NOT NULL,
  `icon7` INT unsigned NOT NULL,
  `icon8` INT unsigned NOT NULL,
  `groupType` TINYINT unsigned NOT NULL,
  `difficulty` TINYINT unsigned NOT NULL DEFAULT 0,
  `raidDifficulty` TINYINT unsigned NOT NULL DEFAULT 0,
  `masterLooterGuid` INT unsigned NOT NULL,
  PRIMARY KEY (`guid`),
  KEY `leaderGuid` (`leaderGuid`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4 COMMENT='Groups';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

