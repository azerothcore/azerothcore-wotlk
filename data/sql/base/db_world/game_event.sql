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

-- Dumpar struktur för tabell acore_world.game_event
DROP TABLE IF EXISTS `game_event`;
CREATE TABLE IF NOT EXISTS `game_event` (
  `eventEntry` TINYINT unsigned NOT NULL COMMENT 'Entry of the game event',
  `start_time` timestamp NULL DEFAULT '2000-01-01 14:00:00' COMMENT 'Absolute start date, the event will never start before',
  `end_time` timestamp NULL DEFAULT '2000-01-01 14:00:00' COMMENT 'Absolute end date, the event will never start after',
  `occurence` BIGINT unsigned NOT NULL DEFAULT '5184000' COMMENT 'Delay in minutes between occurences of the event',
  `length` BIGINT unsigned NOT NULL DEFAULT '2592000' COMMENT 'Length in minutes of the event',
  `holiday` MEDIUMINT unsigned NOT NULL DEFAULT 0 COMMENT 'Client side holiday id',
  `holidayStage` TINYINT unsigned NOT NULL DEFAULT 0,
  `description` VARCHAR(255) DEFAULT NULL COMMENT 'Description of the event displayed in console',
  `world_event` TINYINT unsigned NOT NULL DEFAULT 0 COMMENT '0 if normal event, 1 if world event',
  `announce` TINYINT unsigned NOT NULL DEFAULT '2' COMMENT '0 dont announce, 1 announce, 2 value from config',
  PRIMARY KEY (`eventEntry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_world.game_event: 80 rows
DELETE FROM `game_event`;
/*!40000 ALTER TABLE `game_event` DISABLE KEYS */;
INSERT INTO `game_event` (`eventEntry`, `start_time`, `end_time`, `occurence`, `length`, `holiday`, `holidayStage`, `description`, `world_event`, `announce`) VALUES
	(1, '2021-06-22 00:01:00', '2030-12-31 12:00:00', 525600, 20160, 341, 1, 'Midsummer Fire Festival', 0, 2),
	(2, '2021-12-16 01:00:00', '2030-12-31 12:00:00', 525600, 25920, 141, 1, 'Winter Veil', 0, 2),
	(3, '2020-01-05 06:01:00', '2030-12-31 12:00:00', 131040, 10079, 376, 2, 'Darkmoon Faire (Terokkar Forest)', 0, 2),
	(4, '2014-09-07 06:01:00', '2030-12-31 12:00:00', 131040, 10079, 374, 2, 'Darkmoon Faire (Elwynn Forest)', 0, 2),
	(5, '2014-10-05 06:01:00', '2030-12-31 12:00:00', 131040, 10079, 375, 2, 'Darkmoon Faire (Mulgore)', 0, 2),
	(6, '2021-01-01 07:00:00', '2030-12-31 12:00:00', 525600, 120, 0, 0, 'New Year\'s Eve', 0, 2),
	(7, '2021-01-24 00:01:00', '2030-12-31 12:00:00', 525600, 20160, 327, 1, 'Lunar Festival', 0, 2),
	(8, '2021-02-08 00:01:00', '2030-12-31 12:00:00', 525600, 20160, 423, 1, 'Love is in the Air', 0, 2),
	(9, '2021-04-13 00:01:00', '2030-12-31 12:00:00', 525600, 10080, 181, 1, 'Noblegarden', 0, 2),
	(10, '2021-05-01 00:01:00', '2030-12-31 12:00:00', 525600, 10080, 201, 1, 'Children\'s Week', 0, 2),
	(11, '2021-09-29 00:01:00', '2030-12-31 12:00:00', 525600, 10080, 321, 1, 'Harvest Festival', 0, 2),
	(12, '2021-10-19 00:00:00', '2030-12-31 12:00:00', 525600, 20160, 324, 1, 'Hallow\'s End', 0, 2),
	(13, '2000-01-01 14:00:00', '2000-01-01 14:00:00', 525600, 1, 0, 0, 'Elemental Invasions', 0, 2),
	(14, '2016-10-29 00:00:00', '2030-12-31 07:00:00', 10080, 1440, 0, 0, 'Stranglethorn Fishing Extravaganza Announce', 0, 2),
	(15, '2016-10-30 14:00:00', '2030-12-31 07:00:00', 10080, 120, 301, 0, 'Stranglethorn Fishing Extravaganza Fishing Pools', 0, 2),
	(16, '2007-08-05 10:00:00', '2030-12-31 12:00:00', 180, 120, 0, 0, 'Gurubashi Arena Booty Run', 0, 2),
	(17, '2000-01-01 14:00:00', '2000-01-01 14:00:00', 525600, 1, 0, 0, 'Scourge Invasion', 0, 2),
	(18, '2010-05-07 13:00:00', '2030-12-31 12:00:00', 60480, 6240, 283, 1, 'Call to Arms: Alterac Valley!', 0, 2),
	(19, '2010-04-02 13:00:00', '2030-12-31 12:00:00', 60480, 6240, 284, 1, 'Call to Arms: Warsong Gulch!', 0, 2),
	(20, '2010-04-23 13:00:00', '2030-12-31 12:00:00', 60480, 6240, 285, 1, 'Call to Arms: Arathi Basin!', 0, 2),
	(21, '2010-04-30 13:00:00', '2030-12-31 12:00:00', 60480, 6240, 353, 1, 'Call to Arms: Eye of the Storm!', 0, 2),
	(22, '2000-01-01 14:00:00', '2000-01-01 14:00:00', 525600, 1, 0, 0, 'AQ War Effort', 0, 2),
	(23, '2014-09-04 06:01:00', '2030-12-31 12:00:00', 131040, 4320, 374, 1, 'Darkmoon Faire Building (Elwynn Forest)', 0, 2),
	(24, '2021-09-20 01:01:00', '2030-12-31 13:00:00', 525600, 21600, 372, 2, 'Brewfest', 0, 2),
	(25, '2015-07-29 21:00:00', '2030-12-31 12:00:00', 1440, 540, 0, 0, 'Pyrewood Village', 0, 2),
	(26, '2021-11-23 01:00:00', '2030-12-31 12:00:00', 525600, 10080, 404, 1, 'Pilgrim\'s Bounty', 0, 2),
	(27, '2008-03-24 12:00:00', '2030-12-31 12:00:00', 86400, 21600, 0, 0, 'Edge of Madness, Gri\'lek', 0, 2),
	(28, '2008-04-07 12:00:00', '2030-12-31 12:00:00', 86400, 21600, 0, 0, 'Edge of Madness, Hazza\'rah', 0, 2),
	(29, '2008-04-21 12:00:00', '2030-12-31 12:00:00', 86400, 21600, 0, 0, 'Edge of Madness, Renataki', 0, 2),
	(30, '2008-05-05 12:00:00', '2030-12-31 12:00:00', 86400, 21600, 0, 0, 'Edge of Madness, Wushoolay', 0, 2),
	(31, '2000-01-01 14:00:00', '2000-01-01 14:00:00', 5184000, 2592000, 0, 0, 'Arena Tournament', 0, 2),
	(32, '2008-05-16 02:00:00', '2030-12-31 12:00:00', 10080, 5, 0, 0, 'L70ETC Concert', 0, 2),
	(33, '2011-03-22 06:10:00', '2030-12-31 12:00:00', 30, 5, 0, 0, 'Dalaran: Minigob', 0, 2),
	(34, '2021-10-01 00:01:00', '2030-12-31 12:00:00', 525600, 44640, 0, 0, 'Brew of the Month October', 0, 2),
	(35, '2021-11-01 00:01:00', '2030-12-31 12:00:00', 525600, 43200, 0, 0, 'Brew of the Month November', 0, 2),
	(36, '2021-12-01 00:01:00', '2030-12-31 12:00:00', 525600, 44640, 0, 0, 'Brew of the Month December', 0, 2),
	(37, '2021-01-01 00:01:00', '2030-12-31 12:00:00', 525600, 44640, 0, 0, 'Brew of the Month January', 0, 2),
	(38, '2021-02-01 00:01:00', '2030-12-31 12:00:00', 525600, 40320, 0, 0, 'Brew of the Month February', 0, 2),
	(39, '2021-03-01 00:01:00', '2030-12-31 12:00:00', 525600, 44640, 0, 0, 'Brew of the Month March', 0, 2),
	(40, '2021-04-01 00:01:00', '2030-12-31 12:00:00', 525600, 43200, 0, 0, 'Brew of the Month April', 0, 2),
	(41, '2021-05-01 00:01:00', '2030-12-31 12:00:00', 525600, 44640, 0, 0, 'Brew of the Month May', 0, 2),
	(42, '2021-06-01 00:01:00', '2030-12-31 12:00:00', 525600, 43200, 0, 0, 'Brew of the Month June', 0, 2),
	(43, '2021-07-01 00:01:00', '2030-12-31 12:00:00', 525600, 44640, 0, 0, 'Brew of the Month July', 0, 2),
	(44, '2021-08-01 00:01:00', '2030-12-31 12:00:00', 525600, 44640, 0, 0, 'Brew of the Month August', 0, 2),
	(45, '2021-09-01 00:01:00', '2030-12-31 12:00:00', 525600, 44640, 0, 0, 'Brew of the Month September', 0, 2),
	(48, '2000-01-01 14:00:00', '2000-01-01 14:00:00', 5184000, 2592000, 0, 0, 'Wintergrasp Alliance Defence', 5, 2),
	(49, '2000-01-01 14:00:00', '2000-01-01 14:00:00', 5184000, 2592000, 0, 0, 'Wintergrasp Horde Defence', 5, 2),
	(50, '2021-09-19 01:01:00', '2030-12-31 12:00:00', 525600, 1440, 398, 1, 'Pirates\' Day', 0, 2),
	(51, '2021-11-01 02:00:00', '2030-12-31 12:00:00', 525600, 2820, 409, 1, 'Day of the Dead', 0, 2),
	(52, '2021-12-25 06:00:00', '2030-12-31 12:00:00', 525600, 11700, 0, 0, 'Winter Veil: Gifts', 0, 2),
	(53, '2010-04-09 13:00:00', '2030-12-31 12:00:00', 60480, 6240, 400, 1, 'Call to Arms: Strand of the Ancients!', 0, 2),
	(54, '2010-04-16 13:00:00', '2030-12-31 12:00:00', 60480, 6240, 420, 1, 'Call to Arms: Isle of Conquest!', 0, 2),
	(55, '2000-01-01 14:00:00', '2000-01-01 14:00:00', 5184000, 2592000, 0, 0, 'Arena Season 3', 0, 2),
	(56, '2000-01-01 14:00:00', '2000-01-01 14:00:00', 5184000, 2592000, 0, 0, 'Arena Season 4', 0, 2),
	(57, '2000-01-01 14:00:00', '2000-01-01 14:00:00', 5184000, 2592000, 0, 0, 'Arena Season 5', 0, 2),
	(58, '2000-01-01 14:00:00', '2000-01-01 14:00:00', 5184000, 2592000, 0, 0, 'Arena Season 6', 0, 2),
	(59, '2000-01-01 14:00:00', '2000-01-01 14:00:00', 5184000, 2592000, 0, 0, 'Arena Season 7', 0, 2),
	(60, '2000-01-01 14:00:00', '2000-01-01 14:00:00', 5184000, 2592000, 0, 0, 'Arena Season 8', 0, 2),
	(61, '2010-09-07 06:00:00', '2010-10-10 06:00:00', 9999999, 47520, 0, 0, 'Zalazane\'s Fall', 0, 2),
	(62, '2016-10-30 14:00:00', '2030-12-31 07:00:00', 10080, 180, 0, 0, 'Stranglethorn Fishing Extravaganza Turn-ins', 0, 2),
	(63, '2014-03-22 19:00:00', '2030-12-31 12:00:00', 10080, 180, 0, 0, 'Kalu\'ak Fishing Derby Turn-ins', 0, 2),
	(64, '2014-03-22 20:00:00', '2030-12-31 12:00:00', 10080, 60, 424, 0, 'Kalu\'ak Fishing Derby Fishing Pools', 0, 2),
	(65, '2000-01-01 14:00:00', '2030-12-31 12:00:00', 5184000, 2592000, 0, 0, 'Venture Bay Alliance Defence', 5, 2),
	(66, '2000-01-01 14:00:00', '2000-01-01 14:00:00', 5184000, 2592000, 0, 0, 'Venture Bay Horde Defence', 5, 2),
	(67, '2010-01-02 06:40:00', '2030-12-31 12:00:00', 60, 5, 0, 0, 'AT Event Trigger (Tirion Speech)', 0, 2),
	(68, '2010-01-02 06:55:00', '2030-12-31 12:00:00', 60, 5, 0, 0, 'AT Event Trigger (Horde Event)', 0, 2),
	(69, '2010-01-02 06:10:00', '2030-12-31 12:00:00', 60, 5, 0, 0, 'AT Event Trigger (Alliance Event)', 0, 2),
	(70, '2021-09-20 01:01:00', '2030-12-31 12:00:00', 525600, 4320, 0, 0, 'Brewfest Building (Iron Forge)', 0, 2),
	(71, '2013-01-06 07:01:00', '2030-12-31 12:00:00', 131040, 4320, 375, 1, 'Darkmoon Faire Building (Mulgore)', 0, 2),
	(85, '2011-03-22 01:00:00', '2030-12-31 07:00:00', 5184000, 35, 0, 0, 'Stitches Event', 0, 2),
	(86, '2008-01-02 11:55:00', '2030-12-31 06:00:00', 240, 15, 0, 0, 'Perry Gatner', 0, 2),
	(87, '2008-01-02 11:55:00', '2030-12-31 06:00:00', 5184000, 90, 0, 0, 'Scarlet Oracle', 0, 2),
	(78, '2021-03-20 07:00:00', '2030-12-31 07:00:00', 525600, 262800, 0, 0, 'Summer seasonal fish', 0, 2),
	(73, '2010-01-01 01:00:00', '2030-01-01 01:00:00', 60, 1, 0, 0, 'Hourly Bells', 0, 2),
	(79, '2018-10-28 12:00:00', '2030-12-31 18:00:00', 1440, 360, 0, 0, 'Diurnal fishing event', 0, 2),
	(80, '2018-10-28 00:00:00', '2030-12-31 06:00:00', 1440, 360, 0, 0, 'Nocturnal fishing event', 0, 2),
	(74, '2022-01-01 07:00:00', '2030-01-01 08:00:00', 1440, 60, 0, 0, 'Children of Goldshire', 0, 2),
	(77, '2016-11-06 02:01:00', '2030-12-31 07:00:00', 131040, 4320, 376, 1, 'Darkmoon Faire Building (Terokkar Forest)', 0, 2),
	(88, '2016-10-28 18:00:00', '2030-12-30 23:00:00', 1440, 720, 0, 0, 'Evening', 0, 2),
	(89, '2016-10-28 20:00:00', '2030-12-30 23:00:00', 1440, 600, 0, 0, 'Leprithus', 0, 2);
/*!40000 ALTER TABLE `game_event` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
