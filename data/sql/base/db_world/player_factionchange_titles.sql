/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `player_factionchange_titles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_factionchange_titles` 
(
  `alliance_id` int(8) NOT NULL,
  `alliance_comment` text DEFAULT NULL,
  `horde_id` int(8) NOT NULL,
  `horde_comment` text DEFAULT NULL,
  PRIMARY KEY (`alliance_id`,`horde_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `player_factionchange_titles` WRITE;
/*!40000 ALTER TABLE `player_factionchange_titles` DISABLE KEYS */;
INSERT INTO `player_factionchange_titles` VALUES 
(1,'Private <name>',15,'Scout <name>'),
(2,'Corporal <name>',16,'Grunt <name>'),
(3,'Sergeant <name>',17,'Sergeant <name>'),
(4,'Master Sergeant <name>',18,'Senior Sergeant <name>'),
(5,'Sergeant Major <name>',19,'First Sergeant <name>'),
(6,'Knight <name>',20,'Stone Guard'),
(7,'Knight-Lieutenant <name>',21,'Blood Guard <name>'),
(8,'Knight-Captain <name>',22,'Legionnaire <name>'),
(9,'Knight-Champion <name>',23,'Centurion <name>'),
(10,'Lieutenant Commander <name>',24,'Champion <name>'),
(11,'Commander <name>',25,'Lieutenant General <name>'),
(12,'Marshal  <name>',26,'General <name>'),
(13,'Field Marshal <name>',27,'Warlord <name>'),
(14,'Grand Marshal <name>',28,'High Warlord <name>'),
(48,'Justicar <name>',47,'Conqueror <name>'),
(75,'Flame Warden <name>',76,'Flame Keeper <name>'),
(113,'<name> of Gnomeregan',153,'<name> of Thunder Bluff'),
(126,'<name> of the Alliance',127,'<name> if the Horde'),
(146,'<name> of the Exodar',152,'<name> of Silvermoon'),
(147,'<name> of Darnassus',154,'<name> of the Undercity'),
(148,'<name> of Ironforge',151,'<name> of Sen\'jin'),
(149,'<name> of Stormwind',150,'<name> of Orgrimmar');
/*!40000 ALTER TABLE `player_factionchange_titles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

