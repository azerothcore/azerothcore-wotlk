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

-- Dumpar struktur för tabell acore_world.vehicle_dbc
DROP TABLE IF EXISTS `vehicle_dbc`;
CREATE TABLE IF NOT EXISTS `vehicle_dbc` (
  `ID` INT NOT NULL DEFAULT 0,
  `Flags` INT NOT NULL DEFAULT 0,
  `TurnSpeed` float NOT NULL DEFAULT 0,
  `PitchSpeed` float NOT NULL DEFAULT 0,
  `PitchMin` float NOT NULL DEFAULT 0,
  `PitchMax` float NOT NULL DEFAULT 0,
  `SeatID_1` INT NOT NULL DEFAULT 0,
  `SeatID_2` INT NOT NULL DEFAULT 0,
  `SeatID_3` INT NOT NULL DEFAULT 0,
  `SeatID_4` INT NOT NULL DEFAULT 0,
  `SeatID_5` INT NOT NULL DEFAULT 0,
  `SeatID_6` INT NOT NULL DEFAULT 0,
  `SeatID_7` INT NOT NULL DEFAULT 0,
  `SeatID_8` INT NOT NULL DEFAULT 0,
  `MouseLookOffsetPitch` float NOT NULL DEFAULT 0,
  `CameraFadeDistScalarMin` float NOT NULL DEFAULT 0,
  `CameraFadeDistScalarMax` float NOT NULL DEFAULT 0,
  `CameraPitchOffset` float NOT NULL DEFAULT 0,
  `FacingLimitRight` float NOT NULL DEFAULT 0,
  `FacingLimitLeft` float NOT NULL DEFAULT 0,
  `MsslTrgtTurnLingering` float NOT NULL DEFAULT 0,
  `MsslTrgtPitchLingering` float NOT NULL DEFAULT 0,
  `MsslTrgtMouseLingering` float NOT NULL DEFAULT 0,
  `MsslTrgtEndOpacity` float NOT NULL DEFAULT 0,
  `MsslTrgtArcSpeed` float NOT NULL DEFAULT 0,
  `MsslTrgtArcRepeat` float NOT NULL DEFAULT 0,
  `MsslTrgtArcWidth` float NOT NULL DEFAULT 0,
  `MsslTrgtImpactRadius_1` float NOT NULL DEFAULT 0,
  `MsslTrgtImpactRadius_2` float NOT NULL DEFAULT 0,
  `MsslTrgtArcTexture` VARCHAR(100) DEFAULT NULL,
  `MsslTrgtImpactTexture` VARCHAR(100) DEFAULT NULL,
  `MsslTrgtImpactModel_1` VARCHAR(100) DEFAULT NULL,
  `MsslTrgtImpactModel_2` VARCHAR(100) DEFAULT NULL,
  `CameraYawOffset` float NOT NULL DEFAULT 0,
  `UilocomotionType` INT NOT NULL DEFAULT 0,
  `MsslTrgtImpactTexRadius` float NOT NULL DEFAULT 0,
  `VehicleUIIndicatorID` INT NOT NULL DEFAULT 0,
  `PowerDisplayID_1` INT NOT NULL DEFAULT 0,
  `PowerDisplayID_2` INT NOT NULL DEFAULT 0,
  `PowerDisplayID_3` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- Dumpar data för tabell acore_world.vehicle_dbc: 0 rows
DELETE FROM `vehicle_dbc`;
/*!40000 ALTER TABLE `vehicle_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicle_dbc` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
