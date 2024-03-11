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

-- Dumping structure for table acore_world.vehicleseat_dbc
DROP TABLE IF EXISTS `vehicleseat_dbc`;
CREATE TABLE IF NOT EXISTS `vehicleseat_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `AttachmentID` int NOT NULL DEFAULT '0',
  `AttachmentOffsetX` float NOT NULL DEFAULT '0',
  `AttachmentOffsetY` float NOT NULL DEFAULT '0',
  `AttachmentOffsetZ` float NOT NULL DEFAULT '0',
  `EnterPreDelay` float NOT NULL DEFAULT '0',
  `EnterSpeed` float NOT NULL DEFAULT '0',
  `EnterGravity` float NOT NULL DEFAULT '0',
  `EnterMinDuration` float NOT NULL DEFAULT '0',
  `EnterMaxDuration` float NOT NULL DEFAULT '0',
  `EnterMinArcHeight` float NOT NULL DEFAULT '0',
  `EnterMaxArcHeight` float NOT NULL DEFAULT '0',
  `EnterAnimStart` int NOT NULL DEFAULT '0',
  `EnterAnimLoop` int NOT NULL DEFAULT '0',
  `RideAnimStart` int NOT NULL DEFAULT '0',
  `RideAnimLoop` int NOT NULL DEFAULT '0',
  `RideUpperAnimStart` int NOT NULL DEFAULT '0',
  `RideUpperAnimLoop` int NOT NULL DEFAULT '0',
  `ExitPreDelay` float NOT NULL DEFAULT '0',
  `ExitSpeed` float NOT NULL DEFAULT '0',
  `ExitGravity` float NOT NULL DEFAULT '0',
  `ExitMinDuration` float NOT NULL DEFAULT '0',
  `ExitMaxDuration` float NOT NULL DEFAULT '0',
  `ExitMinArcHeight` float NOT NULL DEFAULT '0',
  `ExitMaxArcHeight` float NOT NULL DEFAULT '0',
  `ExitAnimStart` int NOT NULL DEFAULT '0',
  `ExitAnimLoop` int NOT NULL DEFAULT '0',
  `ExitAnimEnd` int NOT NULL DEFAULT '0',
  `PassengerYaw` float NOT NULL DEFAULT '0',
  `PassengerPitch` float NOT NULL DEFAULT '0',
  `PassengerRoll` float NOT NULL DEFAULT '0',
  `PassengerAttachmentID` int NOT NULL DEFAULT '0',
  `VehicleEnterAnim` int NOT NULL DEFAULT '0',
  `VehicleExitAnim` int NOT NULL DEFAULT '0',
  `VehicleRideAnimLoop` int NOT NULL DEFAULT '0',
  `VehicleEnterAnimBone` int NOT NULL DEFAULT '0',
  `VehicleExitAnimBone` int NOT NULL DEFAULT '0',
  `VehicleRideAnimLoopBone` int NOT NULL DEFAULT '0',
  `VehicleEnterAnimDelay` float NOT NULL DEFAULT '0',
  `VehicleExitAnimDelay` float NOT NULL DEFAULT '0',
  `VehicleAbilityDisplay` int NOT NULL DEFAULT '0',
  `EnterUISoundID` int NOT NULL DEFAULT '0',
  `ExitUISoundID` int NOT NULL DEFAULT '0',
  `UiSkin` int NOT NULL DEFAULT '0',
  `FlagsB` int NOT NULL DEFAULT '0',
  `CameraEnteringDelay` float NOT NULL DEFAULT '0',
  `CameraEnteringDuration` float NOT NULL DEFAULT '0',
  `CameraExitingDelay` float NOT NULL DEFAULT '0',
  `CameraExitingDuration` float NOT NULL DEFAULT '0',
  `CameraOffsetX` float NOT NULL DEFAULT '0',
  `CameraOffsetY` float NOT NULL DEFAULT '0',
  `CameraOffsetZ` float NOT NULL DEFAULT '0',
  `CameraPosChaseRate` float NOT NULL DEFAULT '0',
  `CameraFacingChaseRate` float NOT NULL DEFAULT '0',
  `CameraEnteringZoom` float NOT NULL DEFAULT '0',
  `CameraSeatZoomMin` float NOT NULL DEFAULT '0',
  `CameraSeatZoomMax` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table acore_world.vehicleseat_dbc: ~0 rows (approximately)
DELETE FROM `vehicleseat_dbc`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
