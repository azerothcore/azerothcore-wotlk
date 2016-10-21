/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `locales_creature_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_creature_text` 
(
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `text_loc1` text,
  `text_loc2` text,
  `text_loc3` text,
  `text_loc4` text,
  `text_loc5` text,
  `text_loc6` text,
  `text_loc7` text,
  `text_loc8` text,
  PRIMARY KEY (`entry`,`groupid`,`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `locales_creature_text` WRITE;
/*!40000 ALTER TABLE `locales_creature_text` DISABLE KEYS */;
INSERT INTO `locales_creature_text` VALUES 
(14875,0,0,NULL,NULL,'Beginnt mit dem Ritual. Wir müssen das Herz von Hakkar zurück in die Leere verbannen!',NULL,NULL,NULL,NULL,NULL),
(14875,1,0,NULL,NULL,'All Hail $n, Bezwinger von Hakkar und Held von Azeroth!',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `locales_creature_text` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

