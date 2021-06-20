/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `log_arena_fights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = UTF8MB4 */;
CREATE TABLE `log_arena_fights` 
(
  `fight_id` INT unsigned NOT NULL,
  `time` datetime NOT NULL,
  `type` TINYINT unsigned NOT NULL,
  `duration` INT unsigned NOT NULL,
  `winner` INT unsigned NOT NULL,
  `loser` INT unsigned NOT NULL,
  `winner_tr` SMALLINT unsigned NOT NULL,
  `winner_mmr` SMALLINT unsigned NOT NULL,
  `winner_tr_change` SMALLINT NOT NULL,
  `loser_tr` SMALLINT unsigned NOT NULL,
  `loser_mmr` SMALLINT unsigned NOT NULL,
  `loser_tr_change` SMALLINT NOT NULL,
  `currOnline` INT unsigned NOT NULL,
  PRIMARY KEY (`fight_id`)
) ENGINE=MyISAM DEFAULT CHARSET=UTF8MB4;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `log_arena_fights` WRITE;
/*!40000 ALTER TABLE `log_arena_fights` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_arena_fights` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

