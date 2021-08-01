/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `character_equipmentsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = UTF8MB4 */;
CREATE TABLE `character_equipmentsets` 
(
  `guid` INT NOT NULL DEFAULT 0,
  `setguid` BIGINT NOT NULL AUTO_INCREMENT,
  `setindex` TINYINT unsigned NOT NULL DEFAULT 0,
  `name` varchar(31) NOT NULL,
  `iconname` varchar(100) NOT NULL,
  `ignore_mask` INT unsigned NOT NULL DEFAULT 0,
  `item0` INT unsigned NOT NULL DEFAULT 0,
  `item1` INT unsigned NOT NULL DEFAULT 0,
  `item2` INT unsigned NOT NULL DEFAULT 0,
  `item3` INT unsigned NOT NULL DEFAULT 0,
  `item4` INT unsigned NOT NULL DEFAULT 0,
  `item5` INT unsigned NOT NULL DEFAULT 0,
  `item6` INT unsigned NOT NULL DEFAULT 0,
  `item7` INT unsigned NOT NULL DEFAULT 0,
  `item8` INT unsigned NOT NULL DEFAULT 0,
  `item9` INT unsigned NOT NULL DEFAULT 0,
  `item10` INT unsigned NOT NULL DEFAULT 0,
  `item11` INT unsigned NOT NULL DEFAULT 0,
  `item12` INT unsigned NOT NULL DEFAULT 0,
  `item13` INT unsigned NOT NULL DEFAULT 0,
  `item14` INT unsigned NOT NULL DEFAULT 0,
  `item15` INT unsigned NOT NULL DEFAULT 0,
  `item16` INT unsigned NOT NULL DEFAULT 0,
  `item17` INT unsigned NOT NULL DEFAULT 0,
  `item18` INT unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`setguid`),
  UNIQUE KEY `idx_set` (`guid`,`setguid`,`setindex`),
  KEY `Idx_setindex` (`setindex`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `character_equipmentsets` WRITE;
/*!40000 ALTER TABLE `character_equipmentsets` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_equipmentsets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

