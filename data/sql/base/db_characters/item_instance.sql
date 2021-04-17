/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `item_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = UTF8MB4 */;
CREATE TABLE `item_instance` 
(
  `guid` INT unsigned NOT NULL DEFAULT 0,
  `itemEntry` MEDIUMINT unsigned NOT NULL DEFAULT 0,
  `owner_guid` INT unsigned NOT NULL DEFAULT 0,
  `creatorGuid` INT unsigned NOT NULL DEFAULT 0,
  `giftCreatorGuid` INT unsigned NOT NULL DEFAULT 0,
  `count` INT unsigned NOT NULL DEFAULT 1,
  `duration` INT NOT NULL DEFAULT 0,
  `charges` tinytext DEFAULT NULL,
  `flags` MEDIUMINT unsigned NOT NULL DEFAULT 0,
  `enchantments` text NOT NULL,
  `randomPropertyId` SMALLINT NOT NULL DEFAULT 0,
  `durability` SMALLINT unsigned NOT NULL DEFAULT 0,
  `playedTime` INT unsigned NOT NULL DEFAULT 0,
  `text` text DEFAULT NULL,
  PRIMARY KEY (`guid`),
  KEY `idx_owner_guid` (`owner_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4 COMMENT='Item System';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `item_instance` WRITE;
/*!40000 ALTER TABLE `item_instance` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_instance` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

