/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `arena_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = UTF8MB4 */;
CREATE TABLE `arena_team` 
(
  `arenaTeamId` INT unsigned NOT NULL DEFAULT 0,
  `name` varchar(24) NOT NULL,
  `captainGuid` INT unsigned NOT NULL DEFAULT 0,
  `type` TINYINT unsigned NOT NULL DEFAULT 0,
  `rating` SMALLINT unsigned NOT NULL DEFAULT 0,
  `seasonGames` SMALLINT unsigned NOT NULL DEFAULT 0,
  `seasonWins` SMALLINT unsigned NOT NULL DEFAULT 0,
  `weekGames` SMALLINT unsigned NOT NULL DEFAULT 0,
  `weekWins` SMALLINT unsigned NOT NULL DEFAULT 0,
  `rank` INT unsigned NOT NULL DEFAULT 0,
  `backgroundColor` INT unsigned NOT NULL DEFAULT 0,
  `emblemStyle` TINYINT unsigned NOT NULL DEFAULT 0,
  `emblemColor` INT unsigned NOT NULL DEFAULT 0,
  `borderStyle` TINYINT unsigned NOT NULL DEFAULT 0,
  `borderColor` INT unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`arenaTeamId`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `arena_team` WRITE;
/*!40000 ALTER TABLE `arena_team` DISABLE KEYS */;
/*!40000 ALTER TABLE `arena_team` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

