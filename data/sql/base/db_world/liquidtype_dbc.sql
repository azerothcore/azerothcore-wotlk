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

-- Дамп структуры для таблица _acore_world.liquidtype_dbc
DROP TABLE IF EXISTS `liquidtype_dbc`;
CREATE TABLE IF NOT EXISTS `liquidtype_dbc` (
  `ID` INT NOT NULL DEFAULT 0,
  `Name` varchar(100) DEFAULT NULL,
  `Flags` INT NOT NULL DEFAULT 0,
  `Type` INT NOT NULL DEFAULT 0,
  `SoundID` INT NOT NULL DEFAULT 0,
  `SpellID` INT NOT NULL DEFAULT 0,
  `MaxDarkenDepth` float NOT NULL DEFAULT 0,
  `FogDarkenintensity` float NOT NULL DEFAULT 0,
  `AmbDarkenintensity` float NOT NULL DEFAULT 0,
  `DirDarkenintensity` float NOT NULL DEFAULT 0,
  `LightID` INT NOT NULL DEFAULT 0,
  `ParticleScale` float NOT NULL DEFAULT 0,
  `ParticleMovement` INT NOT NULL DEFAULT 0,
  `ParticleTexSlots` INT NOT NULL DEFAULT 0,
  `MaterialID` INT NOT NULL DEFAULT 0,
  `Texture_1` varchar(100) DEFAULT NULL,
  `Texture_2` varchar(100) DEFAULT NULL,
  `Texture_3` varchar(100) DEFAULT NULL,
  `Texture_4` varchar(100) DEFAULT NULL,
  `Texture_5` varchar(100) DEFAULT NULL,
  `Texture_6` varchar(100) DEFAULT NULL,
  `Color_1` INT NOT NULL DEFAULT 0,
  `Color_2` INT NOT NULL DEFAULT 0,
  `Float_1` float NOT NULL DEFAULT 0,
  `Float_2` float NOT NULL DEFAULT 0,
  `Float_3` float NOT NULL DEFAULT 0,
  `Float_4` float NOT NULL DEFAULT 0,
  `Float_5` float NOT NULL DEFAULT 0,
  `Float_6` float NOT NULL DEFAULT 0,
  `Float_7` float NOT NULL DEFAULT 0,
  `Float_8` float NOT NULL DEFAULT 0,
  `Float_9` float NOT NULL DEFAULT 0,
  `Float_10` float NOT NULL DEFAULT 0,
  `Float_11` float NOT NULL DEFAULT 0,
  `Float_12` float NOT NULL DEFAULT 0,
  `Float_13` float NOT NULL DEFAULT 0,
  `Float_14` float NOT NULL DEFAULT 0,
  `Float_15` float NOT NULL DEFAULT 0,
  `Float_16` float NOT NULL DEFAULT 0,
  `Float_17` float NOT NULL DEFAULT 0,
  `Float_18` float NOT NULL DEFAULT 0,
  `Int_1` INT NOT NULL DEFAULT 0,
  `Int_2` INT NOT NULL DEFAULT 0,
  `Int_3` INT NOT NULL DEFAULT 0,
  `Int_4` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Дамп данных таблицы _acore_world.liquidtype_dbc: 0 rows
DELETE FROM `liquidtype_dbc`;
/*!40000 ALTER TABLE `liquidtype_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `liquidtype_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
