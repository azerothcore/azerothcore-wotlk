/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `addons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `addons` 
(
  `name` varchar(120) NOT NULL DEFAULT '',
  `crc` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Addons';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `addons` WRITE;
/*!40000 ALTER TABLE `addons` DISABLE KEYS */;
INSERT INTO `addons` VALUES 
('Blizzard_AchievementUI',1276933997),
('Blizzard_ArenaUI',1276933997),
('Blizzard_AuctionUI',1276933997),
('Blizzard_BarbershopUI',1276933997),
('Blizzard_BattlefieldMinimap',1276933997),
('Blizzard_BindingUI',1276933997),
('Blizzard_Calendar',1276933997),
('Blizzard_CombatLog',1276933997),
('Blizzard_CombatText',1276933997),
('Blizzard_DebugTools',1276933997),
('Blizzard_GlyphUI',1276933997),
('Blizzard_GMChatUI',1276933997),
('Blizzard_GMSurveyUI',1276933997),
('Blizzard_GuildBankUI',1276933997),
('Blizzard_InspectUI',1276933997),
('Blizzard_ItemSocketingUI',1276933997),
('Blizzard_MacroUI',1276933997),
('Blizzard_RaidUI',1276933997),
('Blizzard_TalentUI',1276933997),
('Blizzard_TimeManager',1276933997),
('Blizzard_TokenUI',1276933997),
('Blizzard_TradeSkillUI',1276933997),
('Blizzard_TrainerUI',1276933997);
/*!40000 ALTER TABLE `addons` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

