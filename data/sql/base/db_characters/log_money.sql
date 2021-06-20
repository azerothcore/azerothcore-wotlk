/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `log_money`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_money` 
(
  `sender_acc` int(11) unsigned NOT NULL,
  `sender_guid` int(11) unsigned NOT NULL,
  `sender_name` char(32) CHARACTER SET utf8 NOT NULL,
  `sender_ip` char(32) CHARACTER SET utf8 NOT NULL,
  `receiver_acc` int(11) unsigned NOT NULL,
  `receiver_name` char(32) CHARACTER SET utf8 NOT NULL,
  `money` bigint(20) unsigned NOT NULL,
  `topic` char(255) CHARACTER SET utf8 NOT NULL,
  `date` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `log_money` WRITE;
/*!40000 ALTER TABLE `log_money` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_money` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

