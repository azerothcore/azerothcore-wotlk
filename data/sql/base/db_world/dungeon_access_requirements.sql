-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: acore_world
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `dungeon_access_requirements`
--

DROP TABLE IF EXISTS `dungeon_access_requirements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dungeon_access_requirements` (
  `dungeon_access_id` tinyint unsigned NOT NULL COMMENT 'ID from dungeon_access_template',
  `requirement_type` tinyint unsigned NOT NULL COMMENT '0 = achiev, 1 = quest, 2 = item',
  `requirement_id` int unsigned NOT NULL COMMENT 'Achiev/quest/item ID',
  `requirement_note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Optional msg shown ingame to player if he cannot enter. You can add extra info',
  `faction` tinyint unsigned NOT NULL DEFAULT '2' COMMENT '0 = Alliance, 1 = Horde, 2 = Both factions',
  `priority` tinyint unsigned DEFAULT NULL COMMENT 'Priority order for the requirement, sorted by type. 0 is the highest priority',
  `leader_only` tinyint NOT NULL DEFAULT '0' COMMENT '0 = check the requirement for the player trying to enter, 1 = check the requirement for the party leader',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`dungeon_access_id`,`requirement_type`,`requirement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Add (multiple) requirements before being able to enter a dungeon/raid';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dungeon_access_requirements`
--

LOCK TABLES `dungeon_access_requirements` WRITE;
/*!40000 ALTER TABLE `dungeon_access_requirements` DISABLE KEYS */;
INSERT INTO `dungeon_access_requirements` VALUES
(17,1,10285,'You must complete the quest \"Return to Andormu\" before entering the Black Morass.',2,NULL,0,'Caverns of Time: Opening the Dark Portal (Normal)'),
(18,1,10285,'You must complete the quest \"Return to Andormu\" and be level 70 before entering the Heroic difficulty of the Black Morass.',2,NULL,1,'Caverns of Time: Opening the Dark Portal (Heroic)'),
(18,2,30635,NULL,2,NULL,0,'Caverns of Time: Opening the Dark Portal (Heroic)'),
(34,2,30622,NULL,0,NULL,0,'Hellfire Citadel: The Shattered Halls (Heroic)'),
(34,2,30637,NULL,1,NULL,0,'Hellfire Citadel: The Shattered Halls (Heroic)'),
(36,2,30622,NULL,0,NULL,0,'Hellfire Citadel: The Blood Furnace (Heroic)'),
(36,2,30637,NULL,1,NULL,0,'Hellfire Citadel: The Blood Furnace (Heroic)'),
(38,2,30622,NULL,0,NULL,0,'Hellfire Citadel: Hellfire Ramparts (Heroic)'),
(38,2,30637,NULL,1,NULL,0,'Hellfire Citadel: Hellfire Ramparts (Heroic)'),
(41,2,30623,NULL,2,NULL,0,'Coilfang Resevoir: The Steamvault (Heroic)'),
(43,2,30623,NULL,2,NULL,0,'Coilfang Resevoir: The Underbog (Heroic)'),
(45,2,30623,NULL,2,NULL,0,'Coilfang Resevoir: The Slave Pens (Heroic)'),
(49,2,30634,NULL,2,NULL,0,'Tempest Keep: The Arcatraz (Heroic)'),
(51,2,30634,NULL,2,NULL,0,'Tempest Keep: The Botanica (Heroic)'),
(53,2,30634,NULL,2,NULL,0,'Tempest Keep: The Mechanar (Heroic)'),
(55,2,30633,NULL,2,NULL,0,'Auchindoun: Shadow Labyrinth (Heroic)'),
(57,2,30633,NULL,2,NULL,0,'Auchindoun: Sethekk Halls (Heroic)'),
(59,2,30633,NULL,2,NULL,0,'Auchindoun: Mana-Tombs (Heroic)'),
(61,2,30633,NULL,2,NULL,0,'Auchindoun: Auchenai Crypts (Heroic)'),
(62,1,10277,'You must complete the quest \"The Caverns of Time\" before entering Old Hillsbrad Foothills',2,NULL,0,'Caverns Of Time: Escape from Durnholde (Normal)'),
(63,1,10277,'You must complete the quest \"The Caverns of Time\" and be level 70 before entering the Heroic difficulty of Old Hillsbrad Foothills',2,NULL,0,'Caverns Of Time: Escape from Durnholde (Heroic)'),
(63,2,30635,NULL,2,NULL,0,'Caverns Of Time: Escape from Durnholde (Heroic)'),
(77,1,11492,'You must complete the quest \"Hard to Kill\" and be level 70 before entering the Heroic difficulty of the Magisters\' Terrace.',2,NULL,0,'Isle of Quel\'Danas: Magisters\' Terrace (Heroic)'),
(104,0,4530,NULL,2,NULL,0,'Icecrown Citadel (10 player, Heroic)'),
(105,0,4597,NULL,2,NULL,0,'Icecrown Citadel (25 player, Heroic)'),
(110,0,3917,NULL,2,NULL,0,'Trial of the Crusader (10 player, Heroic)'),
(111,0,3916,NULL,2,NULL,0,'Trial of the Crusader (25 player, Heroic)'),
(114,1,24499,'You must complete the quest \"Echoes of Tortured Souls\" before entering the Pit of Saron.',0,NULL,0,'Icecrown Citadel: Pit of Saron (Normal)'),
(114,1,24511,'You must complete the quest \"Echoes of Tortured Souls\" before entering the Pit of Saron.',1,NULL,0,'Icecrown Citadel: Pit of Saron (Normal)'),
(115,1,24499,'You must complete the quest \"Echoes of Tortured Souls\" and be level 80 before entering the Heroic difficulty of the Pit of Saron.',0,NULL,0,'Icecrown Citadel: Pit of Saron (Heroic)'),
(115,1,24511,'You must complete the quest \"Echoes of Tortured Souls\" and be level 80 before entering the Heroic difficulty of the Pit of Saron.',1,NULL,0,'Icecrown Citadel: Pit of Saron (Heroic)'),
(116,1,24710,'You must complete the quest \"Deliverance from the Pit\" before entering the Halls of Reflection.',0,NULL,0,'Icecrown Citadel: Halls of Reflection (Normal)'),
(116,1,24712,'You must complete the quest \"Deliverance from the Pit\" before entering the Halls of Reflection.',1,NULL,0,'Icecrown Citadel: Halls of Reflection (Normal)'),
(117,1,24710,'You must complete the quest \"Deliverance from the Pit\" and be level 80 before entering the Heroic difficulty of the Halls of Reflection.',0,NULL,0,'Icecrown Citadel: Halls of Reflection (Heroic)'),
(117,1,24712,'You must complete the quest \"Deliverance from the Pit\" and be level 80 before entering the Heroic difficulty of the Halls of Reflection.',1,NULL,0,'Icecrown Citadel: Halls of Reflection (Heroic)');
/*!40000 ALTER TABLE `dungeon_access_requirements` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-17 22:33:44

