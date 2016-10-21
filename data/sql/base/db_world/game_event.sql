/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `game_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event` 
(
  `eventEntry` tinyint(3) unsigned NOT NULL COMMENT 'Entry of the game event',
  `start_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Absolute start date, the event will never start before',
  `end_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Absolute end date, the event will never start afler',
  `occurence` bigint(20) unsigned NOT NULL DEFAULT '5184000' COMMENT 'Delay in minutes between occurences of the event',
  `length` bigint(20) unsigned NOT NULL DEFAULT '2592000' COMMENT 'Length in minutes of the event',
  `holiday` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Client side holiday id',
  `description` varchar(255) DEFAULT NULL COMMENT 'Description of the event displayed in console',
  `world_event` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0 if normal event, 1 if world event',
  PRIMARY KEY (`eventEntry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `game_event` WRITE;
/*!40000 ALTER TABLE `game_event` DISABLE KEYS */;
INSERT INTO `game_event` VALUES 
(1,'2014-06-21 22:01:00','2020-12-31 05:00:00',525600,20160,341,'Midsummer Fire Festival',0),
(2,'2015-12-16 00:00:00','2020-12-31 05:00:00',525600,25920,141,'Winter Veil',0),
(3,'2014-11-02 00:01:00','2020-12-31 05:00:00',131040,10079,376,'Darkmoon Faire (Terokkar Forest)',0),
(4,'2014-09-06 23:01:00','2020-12-31 05:00:00',131040,10079,374,'Darkmoon Faire (Elwynn Forest)',0),
(5,'2014-10-04 23:01:00','2020-12-31 05:00:00',131040,10079,375,'Darkmoon Faire (Mulgore)',0),
(6,'2010-01-01 06:00:00','2020-12-31 05:00:00',525600,120,0,'New Year\'s Eve',0),
(7,'2015-02-16 00:01:00','2020-12-31 05:00:00',525600,27360,327,'Lunar Festival',0),
(8,'2014-02-03 23:01:00','2020-12-31 05:00:00',525600,20160,423,'Love is in the Air',0),
(9,'2015-04-05 23:00:00','2020-12-31 05:00:00',524160,10080,181,'Noblegarden',0),
(10,'2014-04-27 22:01:00','2020-12-31 05:00:00',525600,10080,201,'Children\'s Week',0),
(11,'2013-09-12 23:01:00','2020-12-31 05:00:00',525600,10080,321,'Harvest Festival',0),
(12,'2014-10-18 22:00:00','2020-12-31 05:00:00',525600,20160,324,'Hallow\'s End',0),
(13,'0000-00-00 00:00:00','0000-00-00 00:00:00',525600,1,0,'Elemental Invasions',0),
(14,'2014-03-23 00:00:00','2020-12-31 05:00:00',10080,1440,0,'Fishing Extravaganza Announce',0),
(15,'2014-03-23 13:00:00','2020-12-31 05:00:00',10080,120,0,'Fishing Extravaganza Fishing Pools',0),
(16,'2007-08-05 03:00:00','2020-12-31 05:00:00',180,120,0,'Gurubashi Arena Booty Run',0),
(17,'0000-00-00 00:00:00','0000-00-00 00:00:00',525600,1,0,'Scourge Invasion',0),
(18,'2010-05-07 06:00:00','2020-12-31 05:00:00',60480,6240,283,'Call to Arms: Alterac Valley!',0),
(19,'2010-04-02 06:00:00','2020-12-31 05:00:00',60480,6240,284,'Call to Arms: Warsong Gulch!',0),
(20,'2010-04-23 06:00:00','2020-12-31 05:00:00',60480,6240,285,'Call to Arms: Arathi Basin!',0),
(21,'2010-04-30 06:00:00','2020-12-31 05:00:00',60480,6240,353,'Call to Arms: Eye of the Storm!',0),
(22,'0000-00-00 00:00:00','0000-00-00 00:00:00',525600,1,0,'AQ War Effort',0),
(23,'2014-09-03 23:01:00','2020-12-31 05:00:00',131040,4320,0,'Darkmoon Faire Building (Elwynn Forest)',0),
(24,'2014-09-20 22:01:00','2020-12-31 05:00:00',525600,21600,372,'Brewfest',0),
(25,'2015-07-29 19:00:00','2020-12-31 05:00:00',1440,480,0,'Pyrewood Village',0),
(26,'2015-11-23 00:00:00','2020-12-30 21:00:00',525600,10019,404,'Pilgrim\'s Bounty',0),
(27,'2008-03-24 05:00:00','2020-12-31 05:00:00',86400,21600,0,'Edge of Madness, Gri\'lek',0),
(28,'2008-04-07 05:00:00','2020-12-31 05:00:00',86400,21600,0,'Edge of Madness, Hazza\'rah',0),
(29,'2008-04-21 05:00:00','2020-12-31 05:00:00',86400,21600,0,'Edge of Madness, Renataki',0),
(30,'2008-05-05 05:00:00','2020-12-31 05:00:00',86400,21600,0,'Edge of Madness, Wushoolay',0),
(31,'0000-00-00 00:00:00','0000-00-00 00:00:00',5184000,2592000,0,'Arena Tournament',0),
(32,'2008-05-15 19:00:00','2020-01-01 07:00:00',10080,5,0,'L70ETC Concert',0),
(33,'2011-03-21 23:10:00','2020-03-21 23:00:00',30,5,0,'Dalaran: Minigob',0),
(34,'2012-09-30 22:01:00','2020-12-31 05:00:00',525600,44640,0,'Brew of the Month October',0),
(35,'2012-10-31 23:01:00','2020-12-31 05:00:00',525600,43200,0,'Brew of the Month November',0),
(36,'2012-11-30 23:01:00','2020-12-31 05:00:00',525600,44640,0,'Brew of the Month December',0),
(37,'2011-12-31 23:01:00','2020-12-31 05:00:00',525600,44640,0,'Brew of the Month January',0),
(38,'2012-01-31 23:01:00','2020-12-31 05:00:00',525600,40320,0,'Brew of the Month February',0),
(39,'2012-02-29 23:01:00','2020-12-31 05:00:00',525600,44640,0,'Brew of the Month March',0),
(40,'2012-03-31 22:01:00','2020-12-31 05:00:00',525600,43200,0,'Brew of the Month April',0),
(41,'2012-04-30 22:01:00','2020-12-31 05:00:00',525600,44640,0,'Brew of the Month May',0),
(42,'2012-05-31 22:01:00','2020-12-31 05:00:00',525600,43200,0,'Brew of the Month June',0),
(43,'2012-06-30 22:01:00','2020-12-31 05:00:00',525600,44640,0,'Brew of the Month July',0),
(44,'2012-07-31 22:01:00','2020-12-31 05:00:00',525600,44640,0,'Brew of the Month August',0),
(45,'2012-08-31 22:01:00','2020-12-31 05:00:00',525600,44640,0,'Brew of the Month September',0),
(48,'0000-00-00 00:00:00','0000-00-00 00:00:00',5184000,2592000,0,'Wintergrasp Alliance Defence',5),
(49,'0000-00-00 00:00:00','0000-00-00 00:00:00',5184000,2592000,0,'Wintergrasp Horde Defence',5),
(50,'2013-09-18 23:01:00','2020-12-31 04:00:00',525600,1440,398,'Pirates\' Day',0),
(51,'2013-11-01 01:00:00','2020-12-31 05:00:00',525600,2820,409,'Day of the Dead',0),
(52,'2015-12-25 05:00:00','2020-12-31 05:00:00',525600,11700,0,'Winter Veil: Gifts',0),
(53,'2010-04-09 06:00:00','2020-12-31 09:00:00',60480,6240,400,'Call to Arms: Strand of the Ancients!',0),
(54,'2010-04-16 06:00:00','2020-12-31 09:00:00',60480,6240,420,'Call to Arms: Isle of Conquest!',0),
(55,'0000-00-00 00:00:00','0000-00-00 00:00:00',5184000,2592000,0,'Arena Season 3',0),
(56,'0000-00-00 00:00:00','0000-00-00 00:00:00',5184000,2592000,0,'Arena Season 4',0),
(57,'0000-00-00 00:00:00','0000-00-00 00:00:00',5184000,2592000,0,'Arena Season 5',0),
(58,'0000-00-00 00:00:00','0000-00-00 00:00:00',5184000,2592000,0,'Arena Season 6',0),
(59,'0000-00-00 00:00:00','0000-00-00 00:00:00',5184000,2592000,0,'Arena Season 7',0),
(60,'0000-00-00 00:00:00','0000-00-00 00:00:00',5184000,2592000,0,'Arena Season 8',0),
(61,'2010-09-06 23:00:00','2010-10-09 23:00:00',9999999,47520,0,'Zalazane\'s Fall',0),
(62,'2014-03-23 13:00:00','2020-12-31 05:00:00',10080,180,301,'Fishing Extravaganza Turn-ins',0),
(63,'2014-03-22 12:00:00','2020-12-31 05:00:00',10080,180,424,'Kalu\'ak Fishing Derby Turn-ins',0),
(64,'2014-03-22 13:00:00','2020-12-31 05:00:00',10080,60,0,'Kalu\'ak Fishing Derby Fishing Pools',0),
(65,'0000-00-00 00:00:00','0000-00-00 00:00:00',5184000,2592000,0,'Venture Bay Alliance Defence',5),
(66,'0000-00-00 00:00:00','0000-00-00 00:00:00',5184000,2592000,0,'Venture Bay Horde Defence',5),
(67,'2010-01-01 23:40:00','2020-12-31 05:00:00',60,5,0,'AT Event Trigger (Tirion Speech)',0),
(68,'2010-01-01 23:55:00','2020-12-31 05:00:00',60,5,0,'AT Event Trigger (Horde Event)',0),
(69,'2010-01-01 23:10:00','2020-12-31 05:00:00',60,5,0,'AT Event Trigger (Alliance Event)',0);
/*!40000 ALTER TABLE `game_event` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

