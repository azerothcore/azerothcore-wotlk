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

-- Dumping structure for table acore_auth.uptime
DROP TABLE IF EXISTS `uptime`;
CREATE TABLE IF NOT EXISTS `uptime` (
  `realmid` int unsigned NOT NULL,
  `starttime` int unsigned NOT NULL DEFAULT '0',
  `uptime` int unsigned NOT NULL DEFAULT '0',
  `maxplayers` smallint unsigned NOT NULL DEFAULT '0',
  `revision` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'AzerothCore',
  PRIMARY KEY (`realmid`,`starttime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Uptime system';

-- Dumping data for table acore_auth.uptime: ~8 rows (approximately)
DELETE FROM `uptime`;
INSERT INTO `uptime` (`realmid`, `starttime`, `uptime`, `maxplayers`, `revision`) VALUES
	(1, 1550400304, 121, 0, 'AzerothCore rev. 2bcedc2859e7 2019-02-17 10:04:09 +0100 (master branch) (Unix, Debug)'),
	(1, 1550400454, 1440, 0, 'AzerothCore rev. 2bcedc2859e7 2019-02-17 10:04:09 +0100 (master branch) (Unix, Debug)'),
	(1, 1661068597, 0, 0, 'AzerothCore rev. 5d6dfca80cf1 2022-08-21 09:48:09 +0200 (new-squash-POGGIES branch) (Win64, RelWithDebInfo, Static)'),
	(1, 1675207201, 0, 0, 'AzerothCore rev. e7cbc80a913b 2023-01-31 22:22:22 +0000 (master branch) (Win64, RelWithDebInfo, Static)'),
	(1, 1682284745, 0, 0, 'AzerothCore rev. 5dc6f9cf78f1 2023-04-23 21:03:18 +0000 (master branch) (Win64, RelWithDebInfo, Static)'),
	(1, 1705757024, 0, 0, 'AzerothCore rev. e6a98aa294c0 2024-01-20 14:06:59 +0100 (checkarchive branch) (Win64, RelWithDebInfo, Static)'),
	(1, 1705757166, 0, 0, 'AzerothCore rev. f60fb6307dc6 2024-01-20 13:20:35 +0000 (it-is-time-for-the-yearly-squash!-hopefully-the-archive-skipping-between-commits-issue-is-solved-now.-only-time-will-tell.-HAPPY-NEW-2024 branch) (Win64, RelWithDebInfo, Static)'),
	(1, 1705764139, 0, 0, 'AzerothCore rev. bd8a08e50dfe+ 2024-01-20 14:48:23 +0100 (it-is-time-for-the-yearly-squash!-hopefully-the-archive-skipping-between-commits-issue-is-solved-now.-only-time-will-tell.-HAPPY-NEW-2024 branch) (Win64, RelWithDebInfo, Static)');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
