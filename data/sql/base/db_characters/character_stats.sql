/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `character_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = UTF8MB4 */;
CREATE TABLE `character_stats` 
(
  `guid` INT unsigned NOT NULL DEFAULT 0 COMMENT 'Global Unique Identifier, Low part',
  `maxhealth` INT unsigned NOT NULL DEFAULT 0,
  `maxpower1` INT unsigned NOT NULL DEFAULT 0,
  `maxpower2` INT unsigned NOT NULL DEFAULT 0,
  `maxpower3` INT unsigned NOT NULL DEFAULT 0,
  `maxpower4` INT unsigned NOT NULL DEFAULT 0,
  `maxpower5` INT unsigned NOT NULL DEFAULT 0,
  `maxpower6` INT unsigned NOT NULL DEFAULT 0,
  `maxpower7` INT unsigned NOT NULL DEFAULT 0,
  `strength` INT unsigned NOT NULL DEFAULT 0,
  `agility` INT unsigned NOT NULL DEFAULT 0,
  `stamina` INT unsigned NOT NULL DEFAULT 0,
  `intellect` INT unsigned NOT NULL DEFAULT 0,
  `spirit` INT unsigned NOT NULL DEFAULT 0,
  `armor` INT unsigned NOT NULL DEFAULT 0,
  `resHoly` INT unsigned NOT NULL DEFAULT 0,
  `resFire` INT unsigned NOT NULL DEFAULT 0,
  `resNature` INT unsigned NOT NULL DEFAULT 0,
  `resFrost` INT unsigned NOT NULL DEFAULT 0,
  `resShadow` INT unsigned NOT NULL DEFAULT 0,
  `resArcane` INT unsigned NOT NULL DEFAULT 0,
  `blockPct` FLOAT NOT NULL DEFAULT 0,
  `dodgePct` FLOAT NOT NULL DEFAULT 0,
  `parryPct` FLOAT NOT NULL DEFAULT 0,
  `critPct` FLOAT NOT NULL DEFAULT 0,
  `rangedCritPct` FLOAT NOT NULL DEFAULT 0,
  `spellCritPct` FLOAT NOT NULL DEFAULT 0,
  `attackPower` INT unsigned NOT NULL DEFAULT 0,
  `rangedAttackPower` INT unsigned NOT NULL DEFAULT 0,
  `spellPower` INT unsigned NOT NULL DEFAULT 0,
  `resilience` INT unsigned NOT NULL DEFAULT 0,
  CHECK (`blockPct`>=0 AND `dodgePct`>=0 AND `parryPct`>=0 AND `critPct`>=0 AND `rangedCritPct`>=0 AND `spellCritPct`>=0),
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `character_stats` WRITE;
/*!40000 ALTER TABLE `character_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_stats` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

