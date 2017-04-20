/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `battleground_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `battleground_template` 
(
  `ID` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `MinPlayersPerTeam` smallint(5) unsigned NOT NULL DEFAULT '0',
  `MaxPlayersPerTeam` smallint(5) unsigned NOT NULL DEFAULT '0',
  `MinLvl` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `MaxLvl` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `AllianceStartLoc` mediumint(8) unsigned NOT NULL,
  `AllianceStartO` float NOT NULL,
  `HordeStartLoc` mediumint(8) unsigned NOT NULL,
  `HordeStartO` float NOT NULL,
  `StartMaxDist` float NOT NULL DEFAULT '0',
  `Weight` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `ScriptName` char(64) NOT NULL DEFAULT '',
  `Comment` char(32) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `battleground_template` WRITE;
/*!40000 ALTER TABLE `battleground_template` DISABLE KEYS */;
INSERT INTO `battleground_template` VALUES 
(1,20,40,51,80,611,3.16312,610,0.715504,100,1,'','Alterac Valley'),
(2,5,10,10,80,769,3.14159,770,0.151581,75,1,'','Warsong Gulch'),
(3,8,15,20,80,890,3.91571,889,0.813671,75,1,'','Arathi Basin'),
(4,0,5,10,80,929,0,936,3.14159,0,1,'','Nagrand Arena'),
(5,0,5,10,80,939,0,940,3.14159,0,1,'','Blades\'s Edge Arena'),
(6,0,5,10,80,0,0,0,0,0,1,'','All Arena'),
(7,8,15,61,80,1103,3.03123,1104,0.055761,75,1,'','Eye of The Storm'),
(8,0,5,10,80,1258,0,1259,3.14159,0,1,'','Ruins of Lordaeron'),
(9,7,15,71,80,1367,0,1368,0,0,1,'','Strand of the Ancients'),
(10,0,5,10,80,1362,0,1363,3.14159,0,1,'','Dalaran Sewers'),
(11,0,5,10,80,1364,0,1365,0,0,1,'','The Ring of Valor'),
(30,20,40,71,80,1485,0,1486,3.16124,200,1,'','Isle of Conquest'),
(32,10,10,80,80,0,0,0,0,0,1,'','Random battleground');
/*!40000 ALTER TABLE `battleground_template` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

