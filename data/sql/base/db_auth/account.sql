/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account` 
(
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identifier',
  `username` varchar(32) NOT NULL DEFAULT '',
  `sha_pass_hash` varchar(40) NOT NULL DEFAULT '',
  `sessionkey` varchar(80) NOT NULL DEFAULT '',
  `v` varchar(64) NOT NULL DEFAULT '',
  `s` varchar(64) NOT NULL DEFAULT '',
  `token_key` varchar(100) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `reg_mail` varchar(255) NOT NULL DEFAULT '',
  `joindate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_ip` varchar(15) NOT NULL DEFAULT '127.0.0.1',
  `last_attempt_ip` varchar(15) NOT NULL DEFAULT '127.0.0.1',
  `failed_logins` int(10) unsigned NOT NULL DEFAULT '0',
  `locked` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `lock_country` varchar(2) NOT NULL DEFAULT '00',
  `last_login` timestamp NULL DEFAULT NULL,
  `online` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `expansion` tinyint(3) unsigned NOT NULL DEFAULT '2',
  `mutetime` bigint(20) NOT NULL DEFAULT '0',
  `mutereason` varchar(255) NOT NULL DEFAULT '',
  `muteby` varchar(50) NOT NULL DEFAULT '',
  `locale` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `os` varchar(3) NOT NULL DEFAULT '',
  `recruiter` int(10) unsigned NOT NULL DEFAULT '0',
  `totaltime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='Account System';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES 
(1,'test1','047ce22643f9b0bd6baeb18d51bf1075a4d43fc6','','','','','','','2016-01-30 21:09:43','127.0.0.1','127.0.0.1',0,0,'00',NULL,0,2,0,'','',0,'',0,0),
(2,'test2','10eb1ff16cf5380147e8281cd8080a210ecb3c53','','','','','','','2016-01-30 21:09:43','127.0.0.1','127.0.0.1',0,0,'00',NULL,0,2,0,'','',0,'',0,0),
(3,'test3','e546bbf9ca93ae5291f0b441bb9ea2fa0c466176','','','','','','','2016-01-30 21:09:43','127.0.0.1','127.0.0.1',0,0,'00',NULL,0,2,0,'','',0,'',0,0),
(4,'test4','61015d83b456a9c6a7defdff07f55265f24097af','','','','','','','2016-01-30 21:09:43','127.0.0.1','127.0.0.1',0,0,'00',NULL,0,2,0,'','',0,'',0,0),
(5,'test5','dddeac4ffe5f286ec57b7a1ed63bf3a859debe1e','','','','','','','2016-01-30 21:09:43','127.0.0.1','127.0.0.1',0,0,'00',NULL,0,2,0,'','',0,'',0,0),
(6,'test6','f1f94cdffd83c8c4182d66689077f92c807ab579','','','','','','','2016-01-30 21:09:43','127.0.0.1','127.0.0.1',0,0,'00',NULL,0,2,0,'','',0,'',0,0),
(7,'test7','6fcd35c35b127be1d9ca040b2b478eb366506ce2','','','','','','','2016-01-30 21:09:43','127.0.0.1','127.0.0.1',0,0,'00',NULL,0,2,0,'','',0,'',0,0),
(8,'test8','484332ccb02e284e4e0a04573c3fa417f4745fdf','','','','','','','2016-01-30 21:09:43','127.0.0.1','127.0.0.1',0,0,'00',NULL,0,2,0,'','',0,'',0,0),
(9,'test9','4fce15ed251721f02754d5381ae9d0137b6a6a30','','','','','','','2016-01-30 21:09:43','127.0.0.1','127.0.0.1',0,0,'00',NULL,0,2,0,'','',0,'',0,0),
(10,'test10','b22d249228e84ab493b39a2bd765bee9b7c0b350','','','','','','','2016-01-30 21:09:43','127.0.0.1','127.0.0.1',0,0,'00',NULL,0,2,0,'','',0,'',0,0);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

