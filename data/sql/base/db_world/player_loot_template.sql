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

-- Dumpar struktur för tabell acore_world.player_loot_template
DROP TABLE IF EXISTS `player_loot_template`;
CREATE TABLE IF NOT EXISTS `player_loot_template` (
  `Entry` MEDIUMINT unsigned NOT NULL DEFAULT 0,
  `Item` MEDIUMINT unsigned NOT NULL DEFAULT 0,
  `Reference` MEDIUMINT NOT NULL DEFAULT 0,
  `Chance` float NOT NULL DEFAULT '100',
  `QuestRequired` TINYINT NOT NULL DEFAULT 0,
  `LootMode` SMALLINT unsigned NOT NULL DEFAULT 1,
  `GroupId` TINYINT unsigned NOT NULL DEFAULT 0,
  `MinCount` TINYINT unsigned NOT NULL DEFAULT 1,
  `MaxCount` TINYINT unsigned NOT NULL DEFAULT 1,
  `Comment` text,
  PRIMARY KEY (`Entry`,`Item`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COMMENT='Loot System';

-- Dumpar data för tabell acore_world.player_loot_template: 12 rows
DELETE FROM `player_loot_template`;
/*!40000 ALTER TABLE `player_loot_template` DISABLE KEYS */;
INSERT INTO `player_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
	(1, 17306, 0, 50, 0, 1, 0, 2, 5, 'Alterac Valley - Alliance - Stormpike Soldiers Blood'),
	(1, 17326, 0, 30, 0, 1, 0, 1, 1, 'Alterac Valley - Alliance - Stormpike Soldiers Flesh'),
	(1, 17327, 0, 20, 0, 1, 0, 1, 1, 'Alterac Valley - Alliance - Stormpike Lieutenants Flesh'),
	(1, 17328, 0, 10, 0, 1, 0, 1, 1, 'Alterac Valley - Alliance - Stormpike Commander\'s Flesh'),
	(1, 17422, 0, 85, 0, 1, 0, 15, 22, 'Alterac Valley - Alliance - Armor Scrapts'),
	(1, 18228, 0, 1, 0, 1, 0, 1, 1, 'Alterac Valley - Alliance - Autographed Picture of Foror & Tigule'),
	(0, 17423, 0, 50, 0, 1, 0, 2, 5, 'Alterac Valley - Horde - Storm Crystal'),
	(0, 17502, 0, 30, 0, 1, 0, 1, 1, 'Alterac Valley - Horde - Frostwolf Soldiers Medal'),
	(0, 17503, 0, 20, 0, 1, 0, 1, 1, 'Alterac Valley - Horde - Frostwolf Lieutenants Medal'),
	(0, 17504, 0, 10, 0, 1, 0, 1, 1, 'Alterac Valley - Horde - Frostwolf Commander\'s Medal'),
	(0, 17422, 0, 85, 0, 1, 0, 15, 22, 'Alterac Valley - Horde - Armor Scraps'),
	(0, 18228, 0, 1, 0, 1, 0, 1, 1, 'Alterac Valley - Horde - Autographed Picture of Foror & Tigule');
/*!40000 ALTER TABLE `player_loot_template` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
