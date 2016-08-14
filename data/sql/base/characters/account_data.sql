/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `account_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_data` 
(
  `accountId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Account Identifier',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `time` int(10) unsigned NOT NULL DEFAULT '0',
  `data` blob NOT NULL,
  PRIMARY KEY (`accountId`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `account_data` WRITE;
/*!40000 ALTER TABLE `account_data` DISABLE KEYS */;
INSERT INTO `account_data` VALUES 
(7,0,1470924545,'SET autoQuestWatch \"0\"\nSET autoQuestProgress \"0\"\nSET flaggedTutorials \"v##M##%##&##$##[##:##)##\\\"\nSET alwaysShowActionBars \"1\"\nSET UnitNameNPC \"1\"\nSET CombatHealing \"0\"\nSET xpBarText \"1\"\nSET playerStatusText \"1\"\nSET petStatusText \"1\"\nSET partyStatusText \"1\"\nSET targetStatusText \"1\"\nSET cameraView \"1\"\nSET cameraDistanceMaxFactor \"1\"\nSET showItemLevel \"1\"\nSET showTutorials \"0\"\nSET serviceTypeFilter \"1\"\nSET talentFrameShown \"1\"\n'),
(7,2,1470922003,'BINDINGMODE 0\r\nbind PRINTSCREEN SCREENSHOT\r\nbind ALT-M CARTOGRAPHER_OPENALTERNATEMAP\r\nbind Ù SCREENSHOT\r\n'),
(7,4,1470922004,'MACRO 9 \"Announce\" Ability_Druid_Berserk\r\n.announce Invitiamo tutti i cittadini di Azeroth a recarsi sulla bacheca del sito per aggiornarsi sulla migrazione e sul downtime indetto per questo primo pomeriggio\r\nEND\r\nMACRO 3 \"damage\" Ability_BackStab\r\n.damage 200000000\r\nEND\r\nMACRO 1 \"Decursive\" INV_Misc_QuestionMark\r\n/script Dcr:Println(\'No spell available\')\r\nEND\r\nMACRO 2 \"hp\" Ability_Ambush\r\n.modify hp 20000000\r\nEND\r\nMACRO 11 \"kick\" Ability_Creature_Disease_05\r\n.cast 51866\r\nEND\r\nMACRO 8 \"LONGMACRO\" Ability_Creature_Disease_02\r\n.modify rep 1098 42999 \r\n.modify rep 1156 42999 \r\n.modify rep 1119 42423 \r\n.modify rep 1091 42999 \r\n.modify rep 1037 42999 \r\n.modify rep 1068 42999 \r\n.modify rep 1126 42999 \r\n.modify rep 1094 42999 \r\n.modify rep 1050 42999 \r\nEND\r\nMACRO 4 \"Mountiful\" INV_Misc_QuestionMark\r\n/click [button:1] Mountiful; [button:2] MOrightclickbutton\r\nEND\r\nMACRO 5 \"shadowmourne\" Ability_Creature_Cursed_03\r\n.quest add 24545\r\n.quest complete 24545\r\n.quest reward 24545\r\n.quest add 24547\r\n.quest complete 24547\r\n.quest reward 24547\r\n.quest add 24749\r\n.quest complete 24749\r\n.quest reward 24749\r\n.quest add 24756\r\n.quest complete 24756\r\n.quest reward 24756\r\nEND\r\nMACRO 6 \"shadowmourne p2\" Ability_Creature_Cursed_03\r\n.quest add 24757\r\n.quest complete 24757\r\n.quest reward 24757\r\n.quest add 24548\r\n.quest complete 24548\r\n.quest reward 24548\r\n.quest add 24549\r\n.quest complete 24549\r\n.quest reward 24549\r\n.quest add 24748\r\n.quest complete 24748\r\n.quest reward 24748\r\nEND\r\nMACRO 7 \"shadowmourne3\" Ability_Creature_Cursed_03\r\n.quest add 24912\r\n.quest complete 24912\r\n.quest reward 24912\r\nEND\r\n');
/*!40000 ALTER TABLE `account_data` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

