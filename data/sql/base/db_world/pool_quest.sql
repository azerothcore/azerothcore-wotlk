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
-- Table structure for table `pool_quest`
--

DROP TABLE IF EXISTS `pool_quest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pool_quest` (
  `entry` int unsigned NOT NULL DEFAULT '0',
  `pool_entry` int unsigned NOT NULL DEFAULT '0',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`entry`),
  KEY `idx_guid` (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pool_quest`
--

LOCK TABLES `pool_quest` WRITE;
/*!40000 ALTER TABLE `pool_quest` DISABLE KEYS */;
INSERT INTO `pool_quest` VALUES
(236,385,'Fueling the Demolishers'),
(11354,356,'Wanted: Nazan\'s Riding Crop'),
(11362,356,'Wanted: Keli\'dan\'s Feathered Stave'),
(11363,356,'Wanted: Bladefist\'s Seal'),
(11364,357,'Wanted: Shattered Hand Centurions'),
(11368,356,'Wanted: The Heart of Quagmirran'),
(11369,356,'Wanted: A Black Stalker Egg'),
(11370,356,'Wanted: The Warlord\'s Treatise'),
(11371,357,'Wanted: Coilfang Myrmidons'),
(11372,356,'Wanted: The Headfeathers of Ikiss'),
(11373,356,'Wanted: Shaffar\'s Wondrous Pendant'),
(11374,356,'Wanted: The Exarch\'s Soul Gem'),
(11375,356,'Wanted: Murmur\'s Whisper'),
(11376,357,'Wanted: Malicious Instructors'),
(11377,352,'Revenge is Tasty'),
(11378,356,'Wanted: The Epoch Hunter\'s Head'),
(11379,352,'Super Hot Stew'),
(11380,352,'Manalicious'),
(11381,352,'Soup for the Soul'),
(11382,356,'Wanted: Aeonus\'s Hourglass'),
(11383,357,'Wanted: Rift Lords'),
(11384,356,'Wanted: A Warp Splinter Clipping'),
(11385,357,'Wanted: Sunseeker Channelers'),
(11386,356,'Wanted: Pathaleon\'s Projector'),
(11387,357,'Wanted: Tempest-Forge Destroyers'),
(11388,356,'Wanted: The Scroll of Skyriss'),
(11389,357,'Wanted: Arcatraz Sentinels'),
(11499,356,'Wanted: The Signet Ring of Prince Kael\'thas'),
(11500,357,'Wanted: Sisters of Torment'),
(11665,353,'Crocolisks in the City'),
(11666,353,'Bait Bandits'),
(11667,353,'The One That Got Away'),
(11668,353,'Shrimpin Aint Easy'),
(11669,353,'Felblood Fillet'),
(12501,386,'Troll Patrol'),
(12563,386,'Troll Patrol'),
(12587,386,'Troll Patrol'),
(12703,362,'Vekgar - Kartak\'s Rampage'),
(12705,382,'Song of Fecundity'),
(12726,380,'Song of Wind and Water'),
(12732,381,'The Heartblood\'s Strength'),
(12734,381,'Rejek: First Blood'),
(12735,380,'A Cleansing Song'),
(12736,380,'Song of Reflection'),
(12737,380,'Song of Fecundity'),
(12741,381,'Strength of the Tempest'),
(12758,381,'A Hero\'s Headgear'),
(12759,362,'Vekgar - Tools of War'),
(12760,362,'Vekgar - Secret Strength of the Frenzyheart'),
(12761,382,'A Cleansing Song'),
(12762,382,'Song of Reflection'),
(12958,5677,'Shipment Blood Jade Amulet'),
(12959,5677,'Shipment Glowing Ivory Figurine'),
(12960,5677,'Shipment Wicked Sun Brooch'),
(12961,5677,'Shipment Intrincate Bone Figurine'),
(12962,5677,'Shipment Bright Armor Relic'),
(12963,5677,'Shipment Shifting Sun Curio'),
(13100,5674,'Infused mushroom Meatloaf Ally'),
(13101,5674,'Convention at the Legerdemain Ally'),
(13102,5674,'Sewer Stew Ally'),
(13103,5674,'Cheese for Glowergold Ally'),
(13107,5674,'Mustard Dogs! Ally'),
(13112,5675,'Infused mushroom Meatloaf Horde'),
(13113,5675,'Convention at the Legerdemain Horde'),
(13114,5675,'Sewer Stew Horde'),
(13115,5675,'Cheese for Glowergold Horde'),
(13116,5675,'Mustard Dogs! Horde'),
(13153,385,'Warding the Warriors'),
(13154,385,'Bones and Arrows'),
(13156,385,'A Rare Herb'),
(13191,384,'Fueling the Demolishers'),
(13192,384,'Warding the Walls'),
(13193,384,'Bones and Arrows'),
(13194,384,'Healing with Roses'),
(13422,354,'Maintaining Discipline'),
(13423,354,'Defending Your Title'),
(13424,354,'Back to the Pit'),
(13600,5669,'A Worthy Weapon Humans'),
(13603,5669,'A Blade Fit For A Champion Humans'),
(13616,5669,'The Edge of Winter Humans'),
(13666,5668,'A Blade Fit For A Champion Convenant'),
(13669,5668,'A Worthy Weapon Convenant'),
(13670,5668,'The Edge of Winter Convenant'),
(13673,5662,'A Blade Fit For A Champion Sunreavers'),
(13674,5662,'A Worthy Weapon Sunreavers'),
(13675,5662,'The Edge of Winter Sunreavers'),
(13741,5670,'A Blade Fit For A Champion Dwarfs'),
(13742,5670,'A Worthy Weapon Dwarfs'),
(13743,5670,'The Edge of Winter Dwarfs'),
(13746,5671,'A Blade Fit For A Champion Gnomes'),
(13747,5671,'A Worthy Weapon Gnomes'),
(13748,5671,'The Edge of Winter Gnomes'),
(13752,5673,'A Blade Fit For A Champion Dranei'),
(13753,5673,'A Worthy Weapon Dranei'),
(13754,5673,'The Edge of Winter Dranei'),
(13757,5672,'A Blade Fit For A Champion Nightelfs'),
(13758,5672,'A Worthy Weapon Nightelfs'),
(13759,5672,'The Edge of Winter Nightelfs'),
(13762,5663,'A Blade Fit For A Champion Orks'),
(13763,5663,'A Worthy Weapon Orks'),
(13764,5663,'The Edge of Winter Orks'),
(13768,5664,'A Blade Fit For A Champion Trolls'),
(13769,5664,'A Worthy Weapon Trolls'),
(13770,5664,'The Edge of Winter Trolls'),
(13773,5665,'A Blade Fit For A Champion Taurens'),
(13774,5665,'A Worthy Weapon Taurens'),
(13775,5665,'The Edge of Winter Taurens'),
(13778,5666,'A Blade Fit For A Champion Undeads'),
(13779,5666,'A Worthy Weapon Undeads'),
(13780,5666,'The Edge of Winter Undeads'),
(13783,5667,'A Blade Fit For A Champion Bloodelfs'),
(13784,5667,'A Worthy Weapon Bloodelfs'),
(13785,5667,'The Edge of Winter Bloodelfs'),
(13830,5676,'The Ghostfish'),
(13832,5676,'Jewel Of The Sewers'),
(13833,5676,'Blood Is Thicker'),
(13834,5676,'Dangerously Delicious'),
(13836,5676,'Disarmed!'),
(13889,350,'Hungry, Hungry Hatchling'),
(13903,350,'Gorishi Grub'),
(13904,350,'Poached, Scrambled, Or Raw?'),
(13905,350,'Searing Roc Feathers'),
(13914,351,'Searing Roc Feathers'),
(13915,351,'Hungry, Hungry Hatchling'),
(13916,351,'Poached, Scrambled, Or Raw?'),
(13917,351,'Gorishi Grub'),
(14074,358,'A Leg Up'),
(14076,359,'Breakfast of Champions'),
(14077,358,'The Light\'s Mercy'),
(14080,358,'Stop The Aggressors'),
(14090,359,'Gormok Wants His Snobolds'),
(14092,361,'Breakfast of Champions'),
(14101,349,'Drottinn Hrothgar'),
(14102,349,'Mistcaller Yngvar'),
(14104,349,'Ornolf The Scarred'),
(14105,349,'Deathspeaker Kharos'),
(14107,363,'The Fate Of The Fallen'),
(14108,363,'Get Kraken!'),
(14112,359,'What Do You Feed a Yeti, Anyway?'),
(14136,360,'Rescue at Sea'),
(14140,360,'Stop The Aggressors'),
(14141,361,'Gormok Wants His Snobolds'),
(14143,360,'A Leg Up'),
(14144,360,'The Light\'s Mercy'),
(14145,361,'What Do You Feed a Yeti, Anyway?'),
(14152,358,'Rescue at Sea'),
(24579,5678,'Sartharion Must Die!'),
(24580,5678,'Anub Rekhan Must Die!'),
(24581,5678,'Noth the Plaguebringer Must Die!'),
(24582,5678,'Instructor Razuvious Must Die!'),
(24583,5678,'Patchwerk Must Die!'),
(24584,5678,'Malygos Must Die!'),
(24585,5678,'Flame Leviathan Must Die!'),
(24586,5678,'Razorscale Must Die!'),
(24587,5678,'Ignis the Furnace Master Must Die!'),
(24588,5678,'XT-002 Deconstructor Must Die!'),
(24589,5678,'Lord Jaraxxus Must Die!'),
(24590,5678,'Lord Marrowgar Must Die!'),
(24629,348,'A Perfect Puff of Perfume'),
(24635,348,'A Cloudlet of Classy Cologne'),
(24636,348,'Bonbon Blitz');
/*!40000 ALTER TABLE `pool_quest` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-29 17:54:23
