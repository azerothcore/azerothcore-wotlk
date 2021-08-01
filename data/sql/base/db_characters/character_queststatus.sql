/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `character_queststatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = UTF8MB4 */;
CREATE TABLE `character_queststatus` 
(
  `guid` INT unsigned NOT NULL DEFAULT 0 COMMENT 'Global Unique Identifier',
  `quest` INT unsigned NOT NULL DEFAULT 0 COMMENT 'Quest Identifier',
  `status` TINYINT unsigned NOT NULL DEFAULT 0,
  `explored` TINYINT unsigned NOT NULL DEFAULT 0,
  `timer` INT unsigned NOT NULL DEFAULT 0,
  `mobcount1` SMALLINT unsigned NOT NULL DEFAULT 0,
  `mobcount2` SMALLINT unsigned NOT NULL DEFAULT 0,
  `mobcount3` SMALLINT unsigned NOT NULL DEFAULT 0,
  `mobcount4` SMALLINT unsigned NOT NULL DEFAULT 0,
  `itemcount1` SMALLINT unsigned NOT NULL DEFAULT 0,
  `itemcount2` SMALLINT unsigned NOT NULL DEFAULT 0,
  `itemcount3` SMALLINT unsigned NOT NULL DEFAULT 0,
  `itemcount4` SMALLINT unsigned NOT NULL DEFAULT 0,
  `itemcount5` SMALLINT unsigned NOT NULL DEFAULT 0,
  `itemcount6` SMALLINT unsigned NOT NULL DEFAULT 0,
  `playercount` SMALLINT unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`,`quest`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4 COMMENT='Player System';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `character_queststatus` WRITE;
/*!40000 ALTER TABLE `character_queststatus` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_queststatus` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

