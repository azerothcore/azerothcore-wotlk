-- MySQL dump 10.13  Distrib 8.4.3, for Win64 (x86_64)
--
-- Host: localhost    Database: acore_world
-- ------------------------------------------------------
-- Server version	8.4.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `player_factionchange_achievement`
--

DROP TABLE IF EXISTS `player_factionchange_achievement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_factionchange_achievement` (
  `alliance_id` int unsigned NOT NULL,
  `alliance_comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `horde_id` int unsigned NOT NULL,
  `horde_comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`alliance_id`,`horde_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_factionchange_achievement`
--

LOCK TABLES `player_factionchange_achievement` WRITE;
/*!40000 ALTER TABLE `player_factionchange_achievement` DISABLE KEYS */;
INSERT INTO `player_factionchange_achievement` VALUES
(33,'Nothing Boring About Borean',1358,'Nothing Boring About Borean'),
(34,'I\'ve Toured the Fjord',1356,'I\'ve Toured the Fjord'),
(35,'Might of Dragonblight',1359,'Might of Dragonblight'),
(37,'Fo\' Grizzle My Shizzle',1357,'Fo\' Grizzle My Shizzle'),
(41,'Loremaster of Northrend',1360,'Loremaster of Northrend'),
(58,'Deaths from Drek\'Thar',593,'Deaths from Vanndar Stormpike'),
(202,'Quick Cap',1502,'Quick Cap'),
(203,'Not In My House',1251,'Not In My House'),
(206,'Supreme Defender',1252,'Supreme Defender'),
(220,'Stormpike Perfection',873,'Frostwolf Perfection'),
(225,'Everything Counts',1164,'Everything Counts'),
(230,'Battlemaster',1175,'Battlemaster'),
(246,'Know Thy Enemy',1005,'Know Thy Enemy'),
(388,'City Defender',1006,'City Defender'),
(433,'Grand Marshal',443,'High Warlord'),
(434,'Field Marshal',445,'Warlord'),
(435,'Commander',444,'Lieutenant General'),
(436,'Lieutenant Commander',447,'Champion'),
(437,'Knight-Champion',448,'Centurion'),
(438,'Knight-Captain',469,'Legionnaire'),
(439,'Knight',451,'Stone Guard'),
(440,'Sergeant Major',452,'First Sergeant'),
(441,'Master Sergeant',450,'Senior Sergeant'),
(442,'Private',454,'Scout'),
(470,'Corporal',468,'Grunt'),
(471,'Sergeant',453,'Sergeant'),
(472,'Knight-Lieutenant',449,'Blood Guard'),
(473,'Marshal',446,'General'),
(604,'Wrath of the Alliance',603,'Wrath of the Horde'),
(610,'Death to the Warchief!',615,'Storming Stormwind'),
(611,'Bleeding Bloodhoof',616,'Death to the King!'),
(612,'Downing the Dark Lady',617,'Immortal No More'),
(613,'Killed in Quel\'Thalas',618,'Putting Out the Light'),
(614,'For The Alliance!',619,'For The Horde!'),
(701,'Freedom of the Alliance',700,'Freedom of the Horde'),
(707,'Stormpike Battle Charger',706,'Frostwolf Howler'),
(709,'Hero of the Stormpike Guard',708,'Hero of the Frostwolf Clan'),
(711,'Knight of Arathor',710,'The Defiler'),
(713,'Silverwing Sentinel',712,'Warsong Outrider'),
(764,'The Burning Crusader',763,'The Burning Crusader'),
(899,'Oh My, Kurenai',901,'Mag\'har of Draenor'),
(907,'The Justicar',714,'The Conqueror'),
(908,'Call to Arms!',909,'Call to Arms!'),
(942,'The Diplomat',943,'The Diplomat'),
(948,'Ambassador of the Alliance',762,'Ambassador of the Horde'),
(963,'Tricks and Treats of Kalimdor',965,'Tricks and Treats of Kalimdor'),
(966,'Tricks and Treats of Eastern Kingdoms',967,'Tricks and Treats of Eastern Kingdoms'),
(969,'Tricks and Treats of Outland',968,'Tricks and Treats of Outland'),
(970,'Tricks and Treats of Azeroth',971,'Tricks and Treats of Azeroth'),
(1012,'The Winds of the North',1011,'The Winds of the North'),
(1022,'Flame Warden of Eastern Kingdoms',1025,'Flame Keeper of Eastern Kingdoms'),
(1023,'Flame Warden of Kalimdor',1026,'Flame Keeper of Kalimdor'),
(1024,'Flame Warden of Outland',1027,'Flame Keeper of Outland'),
(1028,'Extinguishing Eastern Kingdoms',1031,'Extinguishing Eastern Kingdoms'),
(1029,'Extinguishing Kalimdor',1032,'Extinguishing Kalimdor'),
(1030,'Extinguishing Outland',1033,'Extinguishing Outland'),
(1034,'The Fires of Azeroth',1036,'The Fires of Azeroth'),
(1035,'Desecration of the Horde',1037,'Desecration of the Alliance'),
(1038,'The Flame Warden',1039,'The Flame Keeper'),
(1040,'Rotten Hallow',1041,'Rotten Hallow'),
(1151,'Loyal Defender',224,'Loyal Defender'),
(1167,'Master of Alterac Valley',1168,'Master of Alterac Valley'),
(1169,'Master of Arathi Basin',1170,'Master of Arathi Basin'),
(1172,'Master of Warsong Gulch',1173,'Master of Warsong Gulch'),
(1184,'Strange Brew',1203,'Strange Brew'),
(1189,'To Hellfire and Back',1271,'To Hellfire and Back'),
(1191,'Terror of Terokkar',1272,'Terror of Terokkar'),
(1192,'Nagrand Slam',1273,'Nagrand Slam'),
(1255,'Scrooge',259,'Scrooge'),
(1262,'Loremaster of Outland',1274,'Loremaster of Outland'),
(1279,'Flirt With Disaster',1280,'Flirt With Disaster'),
(1466,'Most Alliance factions at Exalted',926,'Most Horde factions at Exalted'),
(1563,'Hail to the Chef',1784,'Hail to the Chef'),
(1656,'Hallowed Be Thy Name',1657,'Hallowed Be Thy Name'),
(1676,'Loremaster of Eastern Kingdoms',1677,'Loremaster of Eastern Kingdoms'),
(1678,'Loremaster of Kalimdor',1680,'Loremaster of Kalimdor'),
(1681,'The Loremaster',1682,'The Loremaster'),
(1684,'Brewmaster',1683,'Brewmaster'),
(1686,'Bros. Before Ho Ho Ho\'s',1685,'Bros. Before Ho Ho Ho\'s'),
(1692,'Merrymaker',1691,'Merrymaker'),
(1697,'Nation of Adoration',1698,'Nation of Adoration'),
(1707,'Fool For Love',1693,'Fool For Love'),
(1737,'Destruction Derby',2476,'Destruction Derby'),
(1752,'Master of Wintergrasp',2776,'Master of Wintergrasp'),
(1757,'Defense of the Ancients',2200,'Defense of the Ancients'),
(1762,'Not Even a Scratch',2192,'Not Even a Scratch'),
(1782,'Our Daily Bread',1783,'Our Daily Bread'),
(2016,'Grizzled Veteran',2017,'Grizzled Veteran'),
(2144,'What A Long, Strange Trip It\'s Been',2145,'What A Long, Strange Trip It\'s Been'),
(2194,'Master of Strand of the Ancients',2195,'Master of Strand of the Ancients'),
(2419,'Spring Fling',2497,'Spring Fling'),
(2421,'Noble Garden',2420,'Noble Garden'),
(2536,'Mountain o\' Mounts',2537,'Mountain o\' Mounts'),
(2760,'Exalted Champion of Darnassus',2768,'Exalted Champion of Thunder Bluff'),
(2761,'Exalted Champion of the Exodar',2767,'Exalted Champion of Silvermoon City'),
(2762,'Exalted Champion of Gnomeregan',2766,'Exalted Champion of Sen\'jin'),
(2763,'Exalted Champion of Ironforge',2769,'Exalted Champion of the Undercity'),
(2764,'Exalted Champion of Stormwind',2765,'Exalted Champion of Orgrimmar'),
(2770,'Exalted Champion of the Alliance',2771,'Exalted Champion of the Horde'),
(2777,'Champion of Darnassus',2786,'Champion of Thunder Bluff'),
(2778,'Champion of the Exodar',2785,'Champion of Silvermoon City'),
(2779,'Champion of Gnomeregan',2784,'Champion of Sen\'jin'),
(2780,'Champion of Ironforge',2787,'Champion of the Undercity'),
(2781,'Champion of Stormwind',2783,'Champion of Orgrimmar'),
(2782,'Champion of the Alliance',2788,'Champion of the Horde'),
(2797,'Noble Gardener',2798,'Noble Gardener'),
(2817,'Exalted Argent Champion of the Alliance',2816,'Exalted Argent Champion of the Horde'),
(3356,'Winterspring Frostsaber',3357,'Venomhide Ravasaur'),
(3478,'Pilgrim',3656,'Pilgrim'),
(3556,'Pilgrim\'s Paunch',3557,'Pilgrim\'s Paunch'),
(3576,'Now We\'re Cookin\'',3577,'Now We\'re Cookin\''),
(3580,'Pilgrim\'s Peril',3581,'Pilgrim\'s Peril'),
(3596,'Pilgrim\'s Progress',3597,'Pilgrim\'s Progress'),
(3676,'A Silver Confidant',3677,'The Sunreavers'),
(3846,'Resource Glut',4176,'Resource Glut'),
(3851,'Mine',4177,'Mine'),
(3856,'Demolition Derby',4256,'Demolition Derby'),
(3857,'Master of Isle of Conquest',3957,'Master of Isle of Conquest'),
(4156,'A Tribute to Immortality',4079,'A Tribute to Immortality'),
(4296,'Trial of the Champion',3778,'Trial of the Champion'),
(4298,'Heroic: Trial of the Champion',4297,'Heroic: Trial of the Champion'),
(4436,'BB King',4437,'BB King'),
(4784,'Emblematic',4785,'Emblematic'),
(4786,'Operation: Gnomeregan',4790,'Zalazane\'s Fall');
/*!40000 ALTER TABLE `player_factionchange_achievement` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-29 17:54:18
