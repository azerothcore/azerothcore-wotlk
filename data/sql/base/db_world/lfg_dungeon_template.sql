/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `lfg_dungeon_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lfg_dungeon_template` 
(
  `dungeonId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Unique id from LFGDungeons.dbc',
  `name` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`dungeonId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `lfg_dungeon_template` WRITE;
/*!40000 ALTER TABLE `lfg_dungeon_template` DISABLE KEYS */;
INSERT INTO `lfg_dungeon_template` VALUES 
(14,'Gnomeregan',-332.22,-2.28,-150.86,2.77),
(18,'Scarlet Monastery - Graveyard',1688.99,1053.48,18.6775,0.00117),
(22,'Uldaman',-226.8,49.09,-46.03,1.39),
(26,'Maraudon - Orange Crystals',1019.69,-458.31,-43.43,0.31),
(30,'Blackrock Depths - Prison',458.32,26.52,-70.67,4.95),
(32,'Lower Blackrock Spire',78.5083,-225.044,49.839,5.1),
(34,'Dire Maul - East',44.4499,-154.822,-2.71201,0),
(36,'Dire Maul - West',-62.9658,159.867,-3.46206,3.14788),
(38,'Dire Maul - North',255.249,-16.0561,-2.58737,4.7),
(40,'Stratholme - Main Gate',3395.09,-3380.25,142.702,0.1),
(163,'Scarlet Monastery - Armory',1610.83,-323.433,18.6738,6.28022),
(164,'Scarlet Monastery - Cathedral',855.683,1321.5,18.6709,0.001747),
(165,'Scarlet Monastery - Library',255.346,-209.09,18.6773,6.26656),
(272,'Maraudon - Purple Crystals',752.91,-616.53,-33.11,1.37),
(273,'Maraudon - Pristine Waters',495.702,17.3372,-96.3128,3.11854),
(274,'Stratholme - Service Entrance',3593.15,-3646.56,138.5,5.33),
(276,'Blackrock Depths - Upper City',872.42,-232.77,-43.752,0.54),
(285,'The Headless Horseman',1797.52,1347.38,18.8876,3.142),
(286,'The Frost Lord Ahune',-100.396,-95.9996,-4.28423,4.71239),
(287,'Coren Direbrew',897.495,-141.976,-49.7563,2.1255),
(288,'The Crown Chemical Co.',-238.075,2166.43,88.853,1.13446);
/*!40000 ALTER TABLE `lfg_dungeon_template` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

