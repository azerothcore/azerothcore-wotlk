/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `character_pet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = UTF8MB4 */;
CREATE TABLE `character_pet` 
(
  `id` INT unsigned NOT NULL DEFAULT 0,
  `entry` INT unsigned NOT NULL DEFAULT 0,
  `owner` INT unsigned NOT NULL DEFAULT 0,
  `modelid` INT unsigned DEFAULT 0,
  `CreatedBySpell` MEDIUMINT unsigned NOT NULL DEFAULT 0,
  `PetType` TINYINT unsigned NOT NULL DEFAULT 0,
  `level` SMALLINT unsigned NOT NULL DEFAULT 1,
  `exp` INT unsigned NOT NULL DEFAULT 0,
  `Reactstate` TINYINT unsigned NOT NULL DEFAULT 0,
  `name` varchar(21) NOT NULL DEFAULT 'Pet',
  `renamed` TINYINT unsigned NOT NULL DEFAULT 0,
  `slot` TINYINT unsigned NOT NULL DEFAULT 0,
  `curhealth` INT unsigned NOT NULL DEFAULT 1,
  `curmana` INT unsigned NOT NULL DEFAULT 0,
  `curhappiness` INT unsigned NOT NULL DEFAULT 0,
  `savetime` INT unsigned NOT NULL DEFAULT 0,
  `abdata` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `owner` (`owner`),
  KEY `idx_slot` (`slot`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4 COMMENT='Pet System';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `character_pet` WRITE;
/*!40000 ALTER TABLE `character_pet` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_pet` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

