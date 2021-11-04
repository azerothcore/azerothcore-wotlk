-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               10.6.4-MariaDB - mariadb.org binary distribution
-- Операционная система:         Win64
-- HeidiSQL Версия:              11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Дамп структуры для таблица _acore_world.creaturemodeldata_dbc
DROP TABLE IF EXISTS `creaturemodeldata_dbc`;
CREATE TABLE IF NOT EXISTS `creaturemodeldata_dbc` (
  `ID` INT NOT NULL DEFAULT 0,
  `Flags` INT NOT NULL DEFAULT 0,
  `ModelName` varchar(100) DEFAULT NULL,
  `SizeClass` INT NOT NULL DEFAULT 0,
  `ModelScale` float NOT NULL DEFAULT 0,
  `BloodID` INT NOT NULL DEFAULT 0,
  `FootprintTextureID` INT NOT NULL DEFAULT 0,
  `FootprintTextureLength` float NOT NULL DEFAULT 0,
  `FootprintTextureWidth` float NOT NULL DEFAULT 0,
  `FootprintParticleScale` float NOT NULL DEFAULT 0,
  `FoleyMaterialID` INT NOT NULL DEFAULT 0,
  `FootstepShakeSize` INT NOT NULL DEFAULT 0,
  `DeathThudShakeSize` INT NOT NULL DEFAULT 0,
  `SoundID` INT NOT NULL DEFAULT 0,
  `CollisionWidth` float NOT NULL DEFAULT 0,
  `CollisionHeight` float NOT NULL DEFAULT 0,
  `MountHeight` float NOT NULL DEFAULT 0,
  `GeoBoxMinX` float NOT NULL DEFAULT 0,
  `GeoBoxMinY` float NOT NULL DEFAULT 0,
  `GeoBoxMinZ` float NOT NULL DEFAULT 0,
  `GeoBoxMaxX` float NOT NULL DEFAULT 0,
  `GeoBoxMaxY` float NOT NULL DEFAULT 0,
  `GeoBoxMaxZ` float NOT NULL DEFAULT 0,
  `WorldEffectScale` float NOT NULL DEFAULT 0,
  `AttachedEffectScale` float NOT NULL DEFAULT 0,
  `MissileCollisionRadius` float NOT NULL DEFAULT 0,
  `MissileCollisionPush` float NOT NULL DEFAULT 0,
  `MissileCollisionRaise` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Дамп данных таблицы _acore_world.creaturemodeldata_dbc: 0 rows
DELETE FROM `creaturemodeldata_dbc`;
/*!40000 ALTER TABLE `creaturemodeldata_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `creaturemodeldata_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
