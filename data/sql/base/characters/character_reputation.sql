/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `character_reputation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_reputation` 
(
  `guid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `faction` smallint(5) unsigned NOT NULL DEFAULT '0',
  `standing` int(11) NOT NULL DEFAULT '0',
  `flags` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`faction`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `character_reputation` WRITE;
/*!40000 ALTER TABLE `character_reputation` DISABLE KEYS */;
INSERT INTO `character_reputation` VALUES 
(1,21,0,64),
(1,46,0,4),
(1,47,0,17),
(1,54,0,17),
(1,59,0,16),
(1,67,0,14),
(1,68,0,6),
(1,69,0,17),
(1,70,0,2),
(1,72,0,17),
(1,76,0,6),
(1,81,0,6),
(1,83,0,4),
(1,86,0,4),
(1,87,0,2),
(1,92,0,2),
(1,93,0,2),
(1,169,0,12),
(1,270,0,16),
(1,289,0,4),
(1,349,0,0),
(1,369,0,64),
(1,469,0,25),
(1,470,0,64),
(1,471,0,20),
(1,509,0,16),
(1,510,0,2),
(1,529,0,0),
(1,530,0,6),
(1,549,0,4),
(1,550,0,4),
(1,551,0,4),
(1,569,0,4),
(1,570,0,4),
(1,571,0,4),
(1,574,0,4),
(1,576,0,2),
(1,577,0,64),
(1,589,0,0),
(1,609,0,0),
(1,729,0,2),
(1,730,0,16),
(1,749,0,0),
(1,809,0,16),
(1,889,0,6),
(1,890,0,16),
(1,891,0,24),
(1,892,0,0),
(1,909,0,16),
(1,910,0,2),
(1,911,0,6),
(1,922,0,6),
(1,930,0,17),
(1,932,0,80),
(1,933,0,16),
(1,934,0,80),
(1,935,0,16),
(1,936,0,28),
(1,941,0,6),
(1,942,0,16),
(1,946,0,16),
(1,947,0,2),
(1,948,0,8),
(1,949,0,24),
(1,952,0,0),
(1,967,0,16),
(1,970,0,0),
(1,978,0,16),
(1,980,0,0),
(1,989,0,16),
(1,990,0,16),
(1,1005,0,4),
(1,1011,0,16),
(1,1012,0,16),
(1,1015,0,2),
(1,1031,0,16),
(1,1037,0,136),
(1,1038,0,16),
(1,1050,0,16),
(1,1052,0,2),
(1,1064,0,6),
(1,1067,0,2),
(1,1068,0,16),
(1,1073,0,16),
(1,1077,0,16),
(1,1082,0,4),
(1,1085,0,6),
(1,1090,0,16),
(1,1091,0,16),
(1,1094,0,16),
(1,1097,0,0),
(1,1098,0,16),
(1,1104,0,0),
(1,1105,0,0),
(1,1106,0,16),
(1,1117,0,12),
(1,1118,0,12),
(1,1119,0,2),
(1,1124,0,6),
(1,1126,0,16),
(1,1136,0,4),
(1,1137,0,4),
(1,1154,0,4),
(1,1155,0,4),
(1,1156,0,16);
/*!40000 ALTER TABLE `character_reputation` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

