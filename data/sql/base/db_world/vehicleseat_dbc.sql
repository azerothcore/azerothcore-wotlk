/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `vehicleseat_dbc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = UTF8MB4 */;
CREATE TABLE `vehicleseat_dbc` 
(
  `ID` INT NOT NULL DEFAULT 0,
  `Flags` INT NOT NULL DEFAULT 0,
  `AttachmentID` INT NOT NULL DEFAULT 0,
  `AttachmentOffsetX` float NOT NULL DEFAULT 0,
  `AttachmentOffsetY` float NOT NULL DEFAULT 0,
  `AttachmentOffsetZ` float NOT NULL DEFAULT 0,
  `EnterPreDelay` float NOT NULL DEFAULT 0,
  `EnterSpeed` float NOT NULL DEFAULT 0,
  `EnterGravity` float NOT NULL DEFAULT 0,
  `EnterMinDuration` float NOT NULL DEFAULT 0,
  `EnterMaxDuration` float NOT NULL DEFAULT 0,
  `EnterMinArcHeight` float NOT NULL DEFAULT 0,
  `EnterMaxArcHeight` float NOT NULL DEFAULT 0,
  `EnterAnimStart` INT NOT NULL DEFAULT 0,
  `EnterAnimLoop` INT NOT NULL DEFAULT 0,
  `RideAnimStart` INT NOT NULL DEFAULT 0,
  `RideAnimLoop` INT NOT NULL DEFAULT 0,
  `RideUpperAnimStart` INT NOT NULL DEFAULT 0,
  `RideUpperAnimLoop` INT NOT NULL DEFAULT 0,
  `ExitPreDelay` float NOT NULL DEFAULT 0,
  `ExitSpeed` float NOT NULL DEFAULT 0,
  `ExitGravity` float NOT NULL DEFAULT 0,
  `ExitMinDuration` float NOT NULL DEFAULT 0,
  `ExitMaxDuration` float NOT NULL DEFAULT 0,
  `ExitMinArcHeight` float NOT NULL DEFAULT 0,
  `ExitMaxArcHeight` float NOT NULL DEFAULT 0,
  `ExitAnimStart` INT NOT NULL DEFAULT 0,
  `ExitAnimLoop` INT NOT NULL DEFAULT 0,
  `ExitAnimEnd` INT NOT NULL DEFAULT 0,
  `PassengerYaw` float NOT NULL DEFAULT 0,
  `PassengerPitch` float NOT NULL DEFAULT 0,
  `PassengerRoll` float NOT NULL DEFAULT 0,
  `PassengerAttachmentID` INT NOT NULL DEFAULT 0,
  `VehicleEnterAnim` INT NOT NULL DEFAULT 0,
  `VehicleExitAnim` INT NOT NULL DEFAULT 0,
  `VehicleRideAnimLoop` INT NOT NULL DEFAULT 0,
  `VehicleEnterAnimBone` INT NOT NULL DEFAULT 0,
  `VehicleExitAnimBone` INT NOT NULL DEFAULT 0,
  `VehicleRideAnimLoopBone` INT NOT NULL DEFAULT 0,
  `VehicleEnterAnimDelay` float NOT NULL DEFAULT 0,
  `VehicleExitAnimDelay` float NOT NULL DEFAULT 0,
  `VehicleAbilityDisplay` INT NOT NULL DEFAULT 0,
  `EnterUISoundID` INT NOT NULL DEFAULT 0,
  `ExitUISoundID` INT NOT NULL DEFAULT 0,
  `UiSkin` INT NOT NULL DEFAULT 0,
  `FlagsB` INT NOT NULL DEFAULT 0,
  `CameraEnteringDelay` float NOT NULL DEFAULT 0,
  `CameraEnteringDuration` float NOT NULL DEFAULT 0,
  `CameraExitingDelay` float NOT NULL DEFAULT 0,
  `CameraExitingDuration` float NOT NULL DEFAULT 0,
  `CameraOffsetX` float NOT NULL DEFAULT 0,
  `CameraOffsetY` float NOT NULL DEFAULT 0,
  `CameraOffsetZ` float NOT NULL DEFAULT 0,
  `CameraPosChaseRate` float NOT NULL DEFAULT 0,
  `CameraFacingChaseRate` float NOT NULL DEFAULT 0,
  `CameraEnteringZoom` float NOT NULL DEFAULT 0,
  `CameraSeatZoomMin` float NOT NULL DEFAULT 0,
  `CameraSeatZoomMax` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=UTF8MB4;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `vehicleseat_dbc` WRITE;
/*!40000 ALTER TABLE `vehicleseat_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicleseat_dbc` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

