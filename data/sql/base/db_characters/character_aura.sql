/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `character_aura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = UTF8MB4 */;
CREATE TABLE `character_aura` 
(
  `guid` INT unsigned NOT NULL DEFAULT 0 COMMENT 'Global Unique Identifier',
  `casterGuid` BIGINT unsigned NOT NULL DEFAULT 0 COMMENT 'Full Global Unique Identifier',
  `itemGuid` BIGINT unsigned NOT NULL DEFAULT 0,
  `spell` MEDIUMINT unsigned NOT NULL DEFAULT 0,
  `effectMask` TINYINT unsigned NOT NULL DEFAULT 0,
  `recalculateMask` TINYINT unsigned NOT NULL DEFAULT 0,
  `stackCount` TINYINT unsigned NOT NULL DEFAULT 1,
  `amount0` INT NOT NULL DEFAULT 0,
  `amount1` INT NOT NULL DEFAULT 0,
  `amount2` INT NOT NULL DEFAULT 0,
  `base_amount0` INT NOT NULL DEFAULT 0,
  `base_amount1` INT NOT NULL DEFAULT 0,
  `base_amount2` INT NOT NULL DEFAULT 0,
  `maxDuration` INT NOT NULL DEFAULT 0,
  `remainTime` INT NOT NULL DEFAULT 0,
  `remainCharges` TINYINT unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`,`casterGuid`,`itemGuid`,`spell`,`effectMask`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4 COMMENT='Player System';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `character_aura` WRITE;
/*!40000 ALTER TABLE `character_aura` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_aura` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

