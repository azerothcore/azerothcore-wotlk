/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `spell_enchant_proc_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = UTF8MB4 */;
CREATE TABLE `spell_enchant_proc_data` 
(
  `entry` INT unsigned NOT NULL,
  `customChance` INT unsigned NOT NULL DEFAULT 0,
  `PPMChance` FLOAT NOT NULL DEFAULT 0,
  `procEx` INT unsigned NOT NULL DEFAULT 0,
  CHECK (`PPMChance`>=0),
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=UTF8MB4 ROW_FORMAT=DYNAMIC COMMENT='Spell enchant proc data';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `spell_enchant_proc_data` WRITE;
/*!40000 ALTER TABLE `spell_enchant_proc_data` DISABLE KEYS */;
INSERT INTO `spell_enchant_proc_data` VALUES 
(2,0,8.8,0),
(12,0,8.8,0),
(323,0,8.53,0),
(324,0,8.53,0),
(325,0,8.53,0),
(524,0,8.8,0),
(623,0,8.53,0),
(624,0,8.53,0),
(625,0,8.53,0),
(703,0,21.43,0),
(704,0,21.43,0),
(705,0,21.43,0),
(706,0,21.43,0),
(803,0,6,0),
(912,0,6,0),
(1667,0,8.8,0),
(1668,0,8.8,0),
(1894,0,1.7,0),
(1898,0,6,0),
(1899,0,1,0),
(1900,0,1,0),
(2635,0,8.8,0),
(2641,0,8.53,0),
(2644,0,21.43,0),
(2673,0,1,0),
(2675,0,1,0),
(3225,0,1,0),
(3239,0,3,0),
(3241,0,3,0),
(3251,0,3,0),
(3273,0,3,0),
(3368,0,2,0),
(3369,0,1,0),
(3768,0,8.53,0),
(3769,0,8.53,0),
(3772,0,21.43,0),
(3773,0,21.43,0),
(3782,0,8.8,0),
(3783,0,8.8,0),
(3784,0,8.8,0),
(3789,0,1,0),
(3869,0,1,0);
/*!40000 ALTER TABLE `spell_enchant_proc_data` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

