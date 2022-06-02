-- --------------------------------------------------------
-- Värd:                         127.0.0.1
-- Serverversion:                8.0.28 - MySQL Community Server - GPL
-- Server-OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumpar struktur för tabell acore_world.player_factionchange_spells
DROP TABLE IF EXISTS `player_factionchange_spells`;
CREATE TABLE IF NOT EXISTS `player_factionchange_spells` (
  `alliance_id` INT unsigned NOT NULL,
  `alliance_comment` text NOT NULL,
  `horde_id` INT unsigned NOT NULL,
  `horde_comment` text NOT NULL,
  PRIMARY KEY (`alliance_id`,`horde_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_world.player_factionchange_spells: 112 rows
DELETE FROM `player_factionchange_spells`;
/*!40000 ALTER TABLE `player_factionchange_spells` DISABLE KEYS */;
INSERT INTO `player_factionchange_spells` (`alliance_id`, `alliance_comment`, `horde_id`, `horde_comment`) VALUES
	(458, 'Brown Horse', 6654, 'Brown Wolf'),
	(470, 'Black Stallion', 64658, 'Black Wolf'),
	(472, 'Pinto', 580, 'Timber Wolf'),
	(3561, 'Teleport: Stormwind', 3567, 'Teleport: Orgrimmar'),
	(3562, 'Teleport: Ironforge', 3563, 'Teleport: Undercity'),
	(3565, 'Teleport: Darnassus', 3566, 'Teleport: Thunder Bluff'),
	(6648, 'Chestnut Mare', 6653, 'Dire Wolf'),
	(6777, 'Gray Ram', 8395, 'Emerald Raptor'),
	(6898, 'White Ram', 10796, 'Turquoise Raptor'),
	(6899, 'Brown Ram', 10799, 'Violet Raptor'),
	(8394, 'Striped Frostsaber', 64977, 'Black Skeletal Horse'),
	(10059, 'Portal: Stormwind', 11417, 'Portal: Orgrimmar'),
	(10789, 'Spotted Frostsaber', 17464, 'Brown Skeletal Horse'),
	(10793, 'Striped Nightsaber', 17463, 'Blue Skeletal Horse'),
	(10873, 'Red Mechanostrider', 64657, 'White Kodo'),
	(10969, 'Blue Mechanostrider', 35020, 'Blue Hawkstrider'),
	(11416, 'Portal: Ironforge', 11418, 'Portal: Undercity'),
	(11419, 'Portal: Darnassus', 11420, 'Portal: Thunder Bluff'),
	(13819, 'Warhorse', 34769, 'Summon Warhorse'),
	(15779, 'White Mechanostrider Mod B', 18992, 'Teal Kodo'),
	(16082, 'Palomino', 16080, 'Red Wolf'),
	(16083, 'White Stallion', 16081, 'Winter Wolf'),
	(17229, 'Winterspring Frostsaber', 64659, 'Venomhide Ravasaur'),
	(17453, 'Green Mechanostrider', 18989, 'Gray Kodo'),
	(17459, 'Icy Blue Mechanostrider Mod A', 18991, 'Green Kodo'),
	(17460, 'Frost Ram', 17450, 'Ivory Raptor'),
	(17461, 'Black Ram', 16084, 'Mottled Red Raptor'),
	(22717, 'Black War Steed', 22724, 'Black War Wolf'),
	(22719, 'Black Battlestrider', 22718, 'Black War Kodo'),
	(22720, 'Black War Ram', 22721, 'Black War Raptor'),
	(22723, 'Black War Tiger', 22722, 'Red Skeletal Warhorse'),
	(23214, 'Charger', 34767, 'Summon Charger'),
	(23219, 'Swift Mistsaber', 23246, 'Purple Skeletal Warhorse'),
	(23221, 'Swift Frostsaber', 66846, 'Ochre Skeletal Warhorse'),
	(23222, 'Swift Yellow Mechanostrider', 23247, 'Great White Kodo'),
	(23223, 'Swift White Mechanostrider', 23248, 'Great Gray Kodo'),
	(23225, 'Swift Green Mechanostrider', 23249, 'Great Brown Kodo'),
	(23227, 'Swift Palomino', 23251, 'Swift Timber Wolf'),
	(23228, 'Swift White Steed', 23252, 'Swift Gray Wolf'),
	(23229, 'Swift Brown Steed', 23250, 'Swift Brown Wolf'),
	(23238, 'Swift Brown Ram', 23243, 'Swift Orange Raptor'),
	(23239, 'Swift Gray Ram', 23241, 'Swift Blue Raptor'),
	(23240, 'Swift White Ram', 23242, 'Swift Olive Raptor'),
	(23338, 'Swift Stormsaber', 17465, 'Green Skeletal Warhorse'),
	(23510, 'Stormpike Battle Charger', 23509, 'Frostwolf Howler'),
	(31801, 'Seal of Vengeance', 53736, 'Seal of Corruption'),
	(32182, 'Heroism', 2825, 'Bloodlust'),
	(32235, 'Golden Gryphon', 32245, 'Green Wind Rider'),
	(32239, 'Ebon Gryphon', 32243, 'Tawny Wind Rider'),
	(32240, 'Snowy Gryphon', 32244, 'Blue Wind Rider'),
	(32242, 'Swift Blue Gryphon', 32296, 'Swift Yellow Wind Rider'),
	(32266, 'Portal: Exodar', 32267, 'Portal: Silvermoon'),
	(32271, 'Teleport: Exodar', 32272, 'Teleport: Silvermoon'),
	(32289, 'Swift Red Gryphon', 32246, 'Swift Red Wind Rider'),
	(32290, 'Swift Green Gryphon', 32295, 'Swift Green Wind Rider'),
	(32292, 'Swift Purple Gryphon', 32297, 'Swift Purple Wind Rider'),
	(33690, 'Teleport: Shattrath', 35715, 'Teleport: Shattrath'),
	(33691, 'Portal: Shattrath', 35717, 'Portal: Shattrath'),
	(34406, 'Brown Elekk', 35022, 'Black Hawkstrider'),
	(35710, 'Gray Elekk', 34795, 'Red Hawkstrider'),
	(35711, 'Purple Elekk', 35018, 'Purple Hawkstrider'),
	(35712, 'Great Green Elekk', 35027, 'Swift Purple Hawkstrider'),
	(35713, 'Great Blue Elekk', 35025, 'Swift Green Hawkstrider'),
	(35714, 'Great Purple Elekk', 33660, 'Swift Pink Hawkstrider'),
	(48027, 'Black War Elekk', 35028, 'Swift Warstrider'),
	(49359, 'Teleport: Theramore', 49358, 'Teleport: Stonard'),
	(49360, 'Portal: Theramore', 49361, 'Portal: Stonard'),
	(59785, 'Black War Mammoth', 59788, 'Black War Mammoth'),
	(59791, 'Wooly Mammoth', 59793, 'Wooly Mammoth'),
	(59799, 'Ice Mammoth', 59797, 'Ice Mammoth'),
	(60114, 'Armored Brown Bear', 60116, 'Armored Brown Bear'),
	(60118, 'Black War Bear', 60119, 'Black War Bear'),
	(60424, 'Mekgineer\'s Chopper', 55531, 'Mechano-hog'),
	(60867, 'Mekgineer\'s Chopper', 60866, 'Mechano-hog'),
	(61229, 'Armored Snowy Gryphon', 61230, 'Armored Blue Wind Rider'),
	(61425, 'Traveler\'s Tundra Mammoth', 61447, 'Traveler\'s Tundra Mammoth'),
	(61470, 'Grand Ice Mammoth', 61469, 'Grand Ice Mammoth'),
	(61996, 'Blue Dragonhawk', 61997, 'Red Dragonhawk'),
	(62609, 'Argent Squire', 62746, 'Argent Gruntling'),
	(63232, 'Stormwind Steed', 63640, 'Orgrimmar Wolf'),
	(63636, 'Ironforge Ram', 63635, 'Darkspear Raptor'),
	(63637, 'Darnassian Nightsaber', 63643, 'Forsaken Warhorse'),
	(63638, 'Gnomeregan Mechanostrider', 63641, 'Thunder Bluff Kodo'),
	(63639, 'Exodar Elekk', 63642, 'Silvermoon Hawkstrider'),
	(65637, 'Great Red Elekk', 65639, 'Swift Red Hawkstrider'),
	(65638, 'Swift Moonsaber', 65645, 'White Skeletal Warhorse'),
	(65640, 'Swift Gray Steed', 65646, 'Swift Burgundy Wolf'),
	(65642, 'Turbostrider', 65641, 'Great Golden Kodo'),
	(65643, 'Swift Violet Ram', 65644, 'Swift Purple Raptor'),
	(66087, 'Silver Covenant Hippogryph', 66088, 'Sunreaver Dragonhawk'),
	(66090, 'Quel\'dorei Steed', 66091, 'Sunreaver Hawkstrider'),
	(66847, 'Striped Dawnsaber', 17462, 'Red Skeletal Horse'),
	(67064, 'Royal Moonshroud Robe', 67144, 'Royal Moonshroud Robe'),
	(67065, 'Royal Moonshroud Bracers', 67147, 'Royal Moonshroud Bracers'),
	(67066, 'Merlin\'s Robe', 67146, 'Merlin\'s Robe'),
	(67079, 'Bejeweled Wizard\'s Bracers', 67145, 'Bejeweled Wizard\'s Bracers'),
	(67080, 'Ensorcelled Nerubian Breastplate', 67136, 'Ensorcelled Nerubian Breastplate'),
	(67081, 'Black Chitin Bracers', 67137, 'Black Chitin Bracers'),
	(67082, 'Crusader\'s Dragonscale Breastplate', 67138, 'Crusader\'s Dragonscale Breastplate'),
	(67083, 'Crusader\'s Dragonscale Bracers', 67143, 'Crusader\'s Dragonscale Bracers'),
	(67084, 'Lunar Eclipse Robes', 67140, 'Lunar Eclipse Robes'),
	(67085, 'Moonshadow Armguards', 67141, 'Moonshadow Armguards'),
	(67086, 'Knightbane Carapace', 67142, 'Knightbane Carapace'),
	(67087, 'Bracers of Swift Death', 67139, 'Bracers of Swift Death'),
	(67091, 'Breastplate of the White Knight', 67130, 'Breastplate of the White Knight'),
	(67092, 'Saronite Swordbreakers', 67131, 'Saronite Swordbreakers'),
	(67093, 'Titanium Razorplate', 67132, 'Titanium Razorplate'),
	(67094, 'Titanium Spikeguards', 67133, 'Titanium Spikeguards'),
	(67095, 'Sunforged Breastplate', 67134, 'Sunforged Breastplate'),
	(67096, 'Sunforged Bracers', 67135, 'Sunforged Bracers'),
	(68057, 'Swift Alliance Steed', 68056, 'Swift Horde Wolf'),
	(68187, 'Crusader\'s White Warhorse', 68188, 'Crusader\'s Black Warhorse');
/*!40000 ALTER TABLE `player_factionchange_spells` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
