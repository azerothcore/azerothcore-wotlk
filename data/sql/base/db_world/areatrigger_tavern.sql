-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.1.0 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.3.0.6589
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table acore_world.areatrigger_tavern
DROP TABLE IF EXISTS `areatrigger_tavern`;
CREATE TABLE IF NOT EXISTS `areatrigger_tavern` (
  `id` int unsigned NOT NULL DEFAULT '0' COMMENT 'Identifier',
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `faction` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Trigger System';

-- Dumping data for table acore_world.areatrigger_tavern: ~113 rows (approximately)
DELETE FROM `areatrigger_tavern`;
INSERT INTO `areatrigger_tavern` (`id`, `name`, `faction`) VALUES
	(71, 'Westfall - Sentinel Hill Inn', 2),
	(98, 'Nesingwary\'s Expedition', 6),
	(178, 'Strahnbrad', 4),
	(562, 'Elwynn Forest - Goldshire - Lion\'s Pride Inn', 2),
	(682, 'Redridge Mountains - Lakeshire Inn', 2),
	(707, 'Duskwood - Darkshire - Scarlet Raven Inn', 2),
	(708, 'Hillsbrad Foothills - Southshore Inn', 2),
	(709, 'Dustwallow Marsh - Theramore Isle', 2),
	(712, 'Loch Modan - Thelsamar - Stoutlager Inn', 2),
	(713, 'Wetlands - Menethil Harbor - Deepwater Tavern', 2),
	(715, 'Teldrassil - Dolanaar', 2),
	(716, 'Darkshore - Auberdine', 2),
	(717, 'Ashenvale - Astranaar', 2),
	(719, 'Tirisfal Glades - Brill - Gallows\' End Tavern', 4),
	(720, 'Silverpine Forest ', 4),
	(721, 'Hillsbrad Foothills ', 4),
	(722, 'Mulgore ', 4),
	(742, 'The Barrens ', 4),
	(743, 'The Barrens ', 6),
	(843, 'Durotar ', 4),
	(844, 'Swamp of Sorrows ', 4),
	(862, 'Stranglethorn Vale ', 6),
	(982, 'The Barrens ', 4),
	(1022, 'Stonetalon Mountains ', 4),
	(1023, 'Tanaris ', 6),
	(1024, 'Feralas ', 2),
	(1025, 'Feralas ', 4),
	(1042, 'Wildhammer Keep', 2),
	(1606, 'Badlands ', 4),
	(1646, 'Arathi Highlands ', 4),
	(2266, 'Desolace ', 2),
	(2267, 'Desolace ', 4),
	(2286, 'Thousand Needles ', 4),
	(2287, 'Winterspring ', 6),
	(2610, 'Ashenvale ', 4),
	(2786, 'Stormwind backup rest', 2),
	(3547, 'The Undercity', 4),
	(3690, 'Revantusk Village', 4),
	(3886, 'Grom\'gol Base Camp', 4),
	(3985, 'Cenarion Hold', 6),
	(4058, 'Light\'s Hope Chapel', 6),
	(4090, 'Stonetalon Peak', 2),
	(4108, 'Tranquillien Inn', 4),
	(4109, 'Tranquillen - Upper level Inn', 4),
	(4240, 'Auzre Watch Inn', 2),
	(4241, 'Bloodmyst Isle Blood Watch Inn', 2),
	(4265, 'Fairbreeze Village Inn', 4),
	(4300, 'Cenarion Refugee - Outside Inn', 6),
	(4336, 'Thrallmar Inn', 4),
	(4337, 'Honor Hold Inn', 2),
	(4373, 'Zabra jin Inn', 4),
	(4374, 'Telredor Inn', 2),
	(4375, 'Garadar Inn', 4),
	(4376, 'Telaar Inn', 2),
	(4377, 'Allerian Stronghold Inn', 2),
	(4378, 'Stonebreaker Hold Inn', 4),
	(4380, 'Falcon Watch Inn', 4),
	(4381, 'Temple Of Thelamat Inn', 2),
	(4382, 'Cenarion Refuge', 6),
	(4383, 'Orebor Harborage Inn', 2),
	(4486, 'Falconwing Square Inn', 4),
	(4494, 'Thunderlord Stronghold Inn', 4),
	(4498, 'Old Hillsbrad Foothills Inn', 6),
	(4499, 'Sylvanaar Inn', 2),
	(4521, 'Area 52 Inn', 6),
	(4526, 'Shadowmoon Village Inn', 4),
	(4528, 'Wildhammer Stronghold Inn', 2),
	(4555, 'The Stormspire Inn', 6),
	(4558, 'Toshlay\'s Station Inn', 2),
	(4577, 'Altar of Sha\'tar Inn', 6),
	(4595, 'Mok\'Nathal Village Inn', 4),
	(4607, 'Sanctum of the Stars Inn', 6),
	(4608, 'Sanctum Of The Stars - Upper level Inn', 6),
	(4640, 'Evergrove Inn', 6),
	(4714, 'Mudsprocket Inn', 6),
	(4753, 'Westguard Inn', 2),
	(4755, 'Camp Winterhoof Inn', 4),
	(4756, 'Fort Wildervar Inn', 2),
	(4769, 'The City of Ironforge', 2),
	(4775, 'Brackenwall Village Inn', 4),
	(4847, 'Isle of Quel\'Danas, Sun\'s Reach Harbor Inn', 6),
	(4861, 'Bor\'gorok Outpost Inn', 4),
	(4867, 'Fizzcrank Airstrip Inn', 2),
	(4868, 'Taunka\'le Village Inn', 4),
	(4910, 'Warsong Hold', 4),
	(4961, 'Valiance Keep Inn', 2),
	(4964, 'Stars\'s Rest', 2),
	(4965, 'Amberpine Lodge Inn', 2),
	(4966, 'Westfall Brigae Encampment', 2),
	(4967, 'Camp Oneqwah', 4),
	(4970, 'Conquest Hold', 4),
	(4975, 'Moa\'Ki Harbor', 6),
	(4976, 'Kamagua', 6),
	(4977, 'Unu\'pe Inn', 6),
	(4979, 'Venomspite', 4),
	(4993, 'Wintergarde Keep', 2),
	(5030, 'Spearborn Encampment', 6),
	(5045, 'Agmar\'s Hammer', 4),
	(5062, 'The Argent Strand', 6),
	(5164, 'Zim\'Torga', 6),
	(5182, 'Frosthold', 2),
	(5183, 'K3', 6),
	(5200, 'Brunnhildar Village', 6),
	(5204, 'Bouldercrag\'s Refugee', 6),
	(5217, 'Nesingwary Base Camp', 6),
	(5227, 'Argent Vanguard', 6),
	(5314, 'Wyrmrest Temple', 6),
	(5315, 'Wyrmrest Temple', 6),
	(5316, 'Wyrmrest Temple', 6),
	(5317, 'Wyrmrest Temple', 6),
	(5323, 'Camp Tunka\'lo', 4),
	(5327, 'Krasus\' Landing', 6),
	(5360, 'Grom\'arsh Crash-Site', 4);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
