/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `mail_external` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `receiver` int(10) unsigned NOT NULL,
  `subject` varchar(200) DEFAULT 'Support Message',
  `message` varchar(400) DEFAULT NULL,
  `money` int(10) unsigned NOT NULL DEFAULT '0',
  `item` int(10) unsigned NOT NULL DEFAULT '0',
  `item_count` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=61578 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
