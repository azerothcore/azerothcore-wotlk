/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `scalingstatvalues_dbc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scalingstatvalues_dbc` 
(
  `ID` int(11) NOT NULL DEFAULT 0,
  `Charlevel` int(11) NOT NULL DEFAULT 0,
  `ShoulderBudget` int(11) NOT NULL DEFAULT 0,
  `TrinketBudget` int(11) NOT NULL DEFAULT 0,
  `WeaponBudget1H` int(11) NOT NULL DEFAULT 0,
  `RangedBudget` int(11) NOT NULL DEFAULT 0,
  `ClothShoulderArmor` int(11) NOT NULL DEFAULT 0,
  `LeatherShoulderArmor` int(11) NOT NULL DEFAULT 0,
  `MailShoulderArmor` int(11) NOT NULL DEFAULT 0,
  `PlateShoulderArmor` int(11) NOT NULL DEFAULT 0,
  `WeaponDPS1H` int(11) NOT NULL DEFAULT 0,
  `WeaponDPS2H` int(11) NOT NULL DEFAULT 0,
  `SpellcasterDPS1H` int(11) NOT NULL DEFAULT 0,
  `SpellcasterDPS2H` int(11) NOT NULL DEFAULT 0,
  `RangedDPS` int(11) NOT NULL DEFAULT 0,
  `WandDPS` int(11) NOT NULL DEFAULT 0,
  `SpellPower` int(11) NOT NULL DEFAULT 0,
  `PrimaryBudget` int(11) NOT NULL DEFAULT 0,
  `TertiaryBudget` int(11) NOT NULL DEFAULT 0,
  `ClothCloakArmor` int(11) NOT NULL DEFAULT 0,
  `ClothChestArmor` int(11) NOT NULL DEFAULT 0,
  `LeatherChestArmor` int(11) NOT NULL DEFAULT 0,
  `MailChestArmor` int(11) NOT NULL DEFAULT 0,
  `PlateChestArmor` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `scalingstatvalues_dbc` WRITE;
/*!40000 ALTER TABLE `scalingstatvalues_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `scalingstatvalues_dbc` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

