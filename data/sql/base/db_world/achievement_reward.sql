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
-- Table structure for table `achievement_reward`
--

DROP TABLE IF EXISTS `achievement_reward`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `achievement_reward` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `TitleA` int unsigned NOT NULL DEFAULT '0',
  `TitleH` int unsigned NOT NULL DEFAULT '0',
  `ItemID` int unsigned NOT NULL DEFAULT '0',
  `Sender` int unsigned NOT NULL DEFAULT '0',
  `Subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `MailTemplateID` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `achievement_reward`
--

LOCK TABLES `achievement_reward` WRITE;
/*!40000 ALTER TABLE `achievement_reward` DISABLE KEYS */;
INSERT INTO `achievement_reward` VALUES
(13,0,0,41426,16128,'Level 80','Congratulations on your conviction to reach the 80th season of adventure. You are undoubtedly dedicated to the cause of ridding Azeroth of the evils which have plagued us.$B$BAnd while the journey thus far has been no minor feat, the true battle lies ahead.$B$BFight on!$B$BRhonin',0),
(45,0,0,43348,28070,'You\'ve Been Around!','Well, look at ye!$B$BAnd I thought I had seen some things in this icy place! It seems obvious to this dwarf that you have the fire of the explorer burning in your eyes.$B$BWear this tabard with pride. That way your friends will know who to ask for directions when the time comes!$B$BKeep on the move!$B$BBrann Bronzebeard',0),
(46,78,78,0,0,'','',0),
(230,72,0,0,0,'','',0),
(431,64,64,0,0,NULL,NULL,0),
(432,53,53,0,0,NULL,NULL,0),
(456,139,139,0,0,'','',0),
(614,0,0,44223,29611,'For the Alliance!','War rages throughout our lands. Only the bravest heroes dare challenge strike the Horde where it hurts them most. You are among such heroes.$B$BThe blows you have delivered to the leadership of the Horde will open the door for our final assault. The Horde will bow down to the might of the Alliance.$B$BYour deeds will not go unrewarded. Ride on proudly!$B$B--Your King',0),
(619,0,0,44224,4949,'For The Horde!','In this time of great turmoil true heroes rise from the misery. You are one such great hero.$B$BWar is upon us. Your efforts will further our cause on Azeroth. Your great feats shall go rewarded. Take this prize of Orgrimmar and ride to glory.$B$BFor the Horde!$B$BWarchief Thrall',0),
(714,0,47,0,0,'','',0),
(762,0,130,0,0,'','',0),
(870,126,127,0,0,'','',0),
(871,144,144,0,0,'','',0),
(876,0,0,43349,29533,'I\'ve been watching you, kid.','You\'ve got quite a knack for throwing down in that arena. Keep this. Wear it with pride. Now get back in there and show them how it\'s done!$B$BUncle Sal',0),
(907,48,0,0,0,'','',0),
(913,74,74,0,0,'','',0),
(942,79,0,0,0,'','',0),
(943,0,79,0,0,'','',0),
(945,131,131,0,0,'','',0),
(948,130,0,0,0,'','',0),
(953,132,132,0,0,'','',0),
(978,81,81,0,0,'','',0),
(1015,77,77,0,0,'','',0),
(1021,0,0,40643,29261,'Quite the Achiever','I couldn\'t help but notice what a fine collection of Tabards you\'ve managed to collect over the seasons. You might as well add this one to your collection. It\'s simply been gathering dust in my wardrobe.',0),
(1038,75,0,0,0,'','',0),
(1039,0,76,0,0,'','',0),
(1174,82,82,0,0,'','',0),
(1175,0,72,0,0,'','',0),
(1250,0,0,40653,28951,'Stinker\'s New Home','I\'ve heard how well you take care of our furry friends. I hope you don\'t mind but I must get Stinker a new home. He just refuses to play nice with others.$B$BPlease make sure to feed him twice a day. And um... he has a thing for black cats.$B$B--Breanni',0),
(1400,120,120,0,0,'','',0),
(1402,122,122,0,0,'','',0),
(1516,83,83,0,0,'','',0),
(1563,84,0,0,0,'','',0),
(1656,124,0,0,0,'','',0),
(1657,0,124,0,0,'','',0),
(1658,129,129,0,0,'','',0),
(1681,125,0,43300,7999,'Greetings from Darnassus','Your accomplishments have been profound and far-reaching. Azeroth, with all of the recent turmoil, benefits greatly from those who seek to rid the land of evil.$B$BOnly those who take the time to know our lands understand the sacrifices of the fallen and the valor of our heroes. You are one such hero. Hopefully, you will recant the tales of your adventures for years to come.$B$BOn behalf of the Alliance, I thank you, Loremaster.',0),
(1682,0,125,43300,3057,'Greetings From Thunder Bluff','News of your accomplishments has traveled far. The winds of turmoil howl through our lands. Those who stand to challenge evil are our only hope.$B$BOnly those who listen to the winds understand the debts our fallen heroes have paid to protect our people. May a hero such as yourself live long to tell the tales of your adventures. For only then will we remember how much we have to be thankful for.$B$BOur appreciation runs deep, Loremaster.$B$BFor the Horde!$B$B--Cairne Bloodhoof',0),
(1683,0,133,0,0,'','',0),
(1684,133,0,0,0,'','',0),
(1691,0,134,0,0,'','',0),
(1692,134,0,0,0,'','',0),
(1693,0,135,0,0,'','',0),
(1707,135,0,0,0,'','',0),
(1784,0,84,0,0,'','',0),
(1793,138,137,0,0,'','',0),
(1956,0,0,43824,16128,'Higher Learning','Congratulations on completing your studies on The Schools of Arcane Magic. In recognition of your dedication, I\'m enclosing this special volume completing the series.$B$BI believe you\'ll find this tome particularly entertaining. But I\'ll leave that for your discovery.$B$BSincerely,$B$BRhonin',0),
(2051,140,140,0,0,'','',0),
(2054,121,121,0,0,'','',0),
(2096,0,0,44430,29478,'The Coin Master','Greetings and congratulations on collecting the full set of Dalaran coins! As a reward for all your hard work I have enclosed a freshly minted Titanium Seal of Dalaran. This is a special coin that we only grant to the most ardent of collectors.$B$BI hope you enjoy this special reward. You\'ve earned it!$B$BSincerely,$BJepetto Joybuzz',0),
(2136,0,0,44160,26917,'Glory of the Hero','Champion,$B$BWord has traveled to Wyrmrest Temple of the great heroic deeds you have accomplished since arriving in Northrend.$B$BYour bravery should not go unrecognized. Please accept this gift on behalf of the Aspects. Together we shall rid Azeroth of evil, once and for eternity.$B$BAlexstrasza the Life-Binder',0),
(2143,0,0,44178,32216,'Leading the Cavalry','I couldn\'t help but to notice how good you are with the livestock. With all the activity around here, business has been better than ever for me. I don\'t suppose you\'d mind looking after this Albino Drake for me? I simply don\'t have enough spare minutes in the day to care for all of these animals. Yours, Mei',0),
(2144,0,0,44177,26917,'Time and Time again','With the drums of war pounding in the distance, it is easy for the denizens of Azeroth to forget all that life has to offer.$B$BYou, on the other hand, have maintained the dignity of the good races of Azeroth with your ability to remember what we fight for. To not celebrate our victories is another form of defeat. Remeber that well, Reveler.$B$BMay others be inspired by your good cheer,$B$BAlexstrasza the Life-Binder',0),
(2145,0,0,44177,26917,'Time and Time again','With the drums of war pounding in the distance, it is easy for the denizens of Azeroth to forget all that life has to offer.$B$BYou, on the other hand, have maintained the dignity of the good races of Azeroth with your ability to remember what we fight for. To not celebrate our victories is another form of defeat. Remeber that well, Reveler.$B$BMay others be inspired by your good cheer,$B$BAlexstrasza the Life-Binder',0),
(2186,141,141,0,0,'','',0),
(2187,142,142,0,0,'','',0),
(2188,143,143,0,0,'','',0),
(2336,145,145,0,0,'','',0),
(2516,0,0,44841,28951,'A Friend to Fawn Over','Hello!$B$BI understand you\'ve managed to give even that mischievous Stinker a warm and loving home... I was hoping you might consider taking in another wayward orphan?$B$BThis little fawn is a shy one, but you\'ll have no trouble winning her friendship with the enclosed: her favorite salt lick!$B$B--Breanni',0),
(2536,0,0,44843,32216,'Mountain o\' Mounts','I\'ve heard your stables are nearly as extensive as mine, now. Impressive! Perhaps we can help one another.. I\'ve one too many dragonhawks, and hoped you could give this one a home. Naturally its been trained as a mount and not a hunting pet, and you\'ll find it as loyal and tireless as any other steed I raise. $B Yours again,Mei',0),
(2537,0,0,44842,32216,'Mountain o\' Mounts','I\'ve heard your stables are nearly as extensive as mine, now. Impressive! Perhaps we can help one another.. I\'ve one too many dragonhawks, and hoped you could give this one a home. Naturally its been trained as a mount and not a hunting pet, and you\'ll find it as loyal and tireless as any other steed I raise. $B Yours again,Mei',0),
(2760,147,0,0,0,'','',0),
(2761,146,0,0,0,'','',0),
(2762,113,0,0,0,'','',0),
(2763,148,0,0,0,'','',0),
(2764,149,0,0,0,'','',0),
(2765,0,150,0,0,'','',0),
(2766,0,151,0,0,'','',0),
(2767,0,152,0,0,'','',0),
(2768,0,153,0,0,'','',0),
(2769,0,154,0,0,'','',0),
(2796,0,0,0,27487,'Welcome to the Brew of the Month Club!','$N,$B$BWelcome to the Brew of the Month club! This club is dedicated to bringing you some of the finest brew in all the realms.$B$BEvery month a new brew will be mailed directly to you. If you enjoy that brew and want more, talk to the Brew of the Month club members there.$B$BAgain, welcome to the club, $N.$B$B- Brew of the Month Club',0),
(2797,155,0,0,0,'','',0),
(2798,0,155,0,0,'','',0),
(2816,0,156,0,0,'','',0),
(2817,156,0,0,0,'','',0),
(2903,161,161,0,0,'','',0),
(2904,160,160,0,0,'','',0),
(2957,0,0,45802,28070,'Glory of the Ulduar Rider','Dear $N,$B$BI hope ye\'re doing well and that ye\'ve had time to recover from our shennanigans in Ulduar.$B$BMe lads from the prospecting team happened upon this poor \'alf dead riding-drake hatchling. Must\'ve been an Iron Dwarf experiment of some sort.$B$BWe\'ve patched him back to health and you\'ll find he\'s not so wee anymore! None of us know much about riding anything but rams and pack mules and since we owed ye one for what ye did back there... We thought perhaps you\'d accept him as a gift.$B$BYours,$BBrann Bronzebeard',0),
(2958,0,0,45801,28070,'Heroic: Glory of the Ulduar Raider','Dear $N,$B$BI hope ye\'re doing well and that ye\'ve had time to recover from our shennanigans in Ulduar.$B$BMe lads from the prospecting team happened upon this poor \'alf dead riding-drake hatchling. Must\'ve been an Iron Dwarf experiment of some sort.$B$BWe\'ve patched him back to health and you\'ll find he\'s not so wee anymore! None of us know much about riding anything but rams and pack mules and since we owed ye one for what ye did back there... We thought perhaps you\'d accept him as a gift.$B$BYours,$BBrann Bronzebeard',0),
(3036,164,164,0,0,'','',0),
(3037,165,165,0,0,'','',0),
(3117,158,158,0,0,'','',0),
(3259,159,159,0,0,'','',0),
(3316,166,166,0,0,'','',0),
(3478,168,0,44810,28951,'A Gobbler not yet Gobbled','Can you believe this Plump Turkey made it through November alive?$N$NSince all his friends have been served up on Bountiful Tables with sides of Cranberry Chutney and Spice Bread and... ooo... I\'m getting hungry. But anyhow! He\'s all alone, now, so I was hoping you might be willing to take care of him. There simply isn\'t enough room left in my shop!$N$NJust keep him away from cooking fires, please. He gets this strange look in his eyes around them...$N$N-Breanni',0),
(3656,0,168,44810,28951,'A Gobbler not yet Gobbled','Can you believe this Plump Turkey made it through November alive?\r\n\r\nSince all this friends have been served up on Bountiful Tables with sides of Cranberry Chutney and Spice Bread Stuffing and... ooo... I\'m getting hungry. But anyhow! He\'s all alone, now, so I was hoping you might be willing to take care of him. There simply isn\'t enough room left in my shop!\r\n\r\nJust keep him away from cooking fires, please. He gets this strange look in his eyes around them...',0),
(3857,0,0,49052,34924,'Master of Isle of Conquest','Honorable $N,$B$BFor your deeds upon the Isle of Conquest, it is my honor to present you with this tabard. Wear it proudly.$B$BHigh Commander, 7th Legion',0),
(3957,0,0,49054,34922,'Master of Isle of Conquest','Honorable $N,$B$BFor your deeds upon the Isle of Conquest, it is my honor to present you with this tabard. Wear it proudly.$B$BOverlord Agmar',0),
(4078,170,170,0,0,'','',0),
(4079,0,0,49098,36095,'A Tribute to Immortality','Dear $N,$B$BTales of your recent performance in the Trial of the Grand Crusader will be told,and retold,for ages to come. As the Argent Crusade issued its call for the greatest champions of Azeroth to test their mettle in the crucible of the Coliseum,I hoped against hope that beacons of light such as you and your companions might emerge from the fray.$B$BWe will need you direly in the coming battle against the Lich King. But on this day,rejoice and celebrate your glorious accomplishment and accept this gift of one of our very finest warhorses. When the Scourge see its banner looming on the horizon,hero,their end shall be nigh!$B$BYours with Honor,$BTirion Fordring',0),
(4080,171,171,0,0,'','',0),
(4156,0,0,49096,36095,'A Tribute to Immortality','Dear $N,$B$BTales of your recent performance in the Trial of the Grand Crusader will be told,and retold,for ages to come. As the Argent Crusade issued its call for the greatest champions of Azeroth to test their mettle in the crucible of the Coliseum,I hoped against hope that beacons of light such as you and your companions might emerge from the fray.$B$BWe will need you direly in the coming battle against the Lich King. But on this day,rejoice and celebrate your glorious accomplishment and accept this gift of one of our very finest warhorses. When the Scourge see its banner looming on the horizon,hero,their end shall be nigh!$B$BYours with Honor,$BTirion Fordring',0),
(4477,172,172,0,0,'','',0),
(4478,0,0,49912,32842,'P.U.G.','Dear very patient individual,$B$BWe\'d like to recognize your tenacity in running dungeons with people you probably haven\'t met before. Hopefully you even showed some rookies the ropes in your pick-up groups.$B$BIn short, we heard you like pugs. So here\'s a pug for your pug, so you can pug while you pug. Or something.$B$BHugs,$B$BYour friends on the WoW Dev Team.',0),
(4530,175,175,0,0,'','',0),
(4583,174,174,0,0,'','',0),
(4584,173,173,0,0,'','',0),
(4597,175,175,0,0,'','',0),
(4598,176,176,0,0,'','',0),
(4602,0,0,51954,37120,'Glory of the Icecrown Raider','$N,$B$BAs the Lich King\'s influence wanes, some of his more powerful minions have wrested free of his grasp.$B$BThis frost wyrm drake my men captured is a prime example. She has a will of her own and then some.$B$BOne of my men lost an arm breaking her in, but she now takes to riders fairly well -- provided they themselves are skilled and strong willed.$B$BPlease accept this magnificent beast as a gift from the Knights of the Ebon Blade. It was an honor to fight along your side in this greatest of battles.$B$BWith honor,$BDarion Mograine.',0),
(4603,0,0,51955,37120,'Glory of the Icecrown Raider','$N,$B$BAs the Lich King\'s influence wanes, some of his more powerful minions have wrested free of his grasp.$B$BThis frost wyrm drake my men captured is a prime example. She has a will of her own and then some.$B$BOne of my men lost an arm breaking her in, but she now takes to riders fairly well -- provided they themselves are skilled and strong willed.$B$BPlease accept this magnificent beast as a gift from the Knights of the Ebon Blade. It was an honor to fight along your side in this greatest of battles.$B$BWith honor,$BDarion Mograine.',0),
(4784,0,0,0,37942,'Emblem Quartermasters in Dalaran\'s Silver Enclave','Your achievements in Northrend have not gone unnoticed, friend.$B$BThe Emblems you have earned may be used to purchase equipment from the various Emblem Quartermasters in Dalaran.$B$BYou may find us there, in the Silver Enclave, where each variety of Emblem has its own quartermaster.$B$BWe look forward to your arrival!',0),
(4785,0,0,0,37941,'Emblem Quartermasters in Dalaran\'s Sunreaver Sanctuary','Your achievements in Northrend have not gone unnoticed, friend.$B$BThe Emblems you have earned may be used to purchase equipment from the various Emblem Quartermasters in Dalaran.$B$BYou may find us there, in the Sunreaver Sanctuary, where each variety of Emblem has its own quartermaster.$B$BWe look forward to your arrival!',0);
/*!40000 ALTER TABLE `achievement_reward` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-17 22:33:14

