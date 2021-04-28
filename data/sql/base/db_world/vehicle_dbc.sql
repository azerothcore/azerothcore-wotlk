/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `vehicle_dbc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = UTF8MB4 */;
CREATE TABLE `vehicle_dbc` 
(
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
  `MsslTrgtArcTexture` varchar(100) DEFAULT NULL,
  `MsslTrgtImpactTexture` varchar(100) DEFAULT NULL,
  `MsslTrgtImpactModel_1` varchar(100) DEFAULT NULL,
  `MsslTrgtImpactModel_2` varchar(100) DEFAULT NULL,
  `CameraYawOffset` float NOT NULL DEFAULT 0,
  `UilocomotionType` INT NOT NULL DEFAULT 0,
  `MsslTrgtImpactTexRadius` float NOT NULL DEFAULT 0,
  `VehicleUIIndicatorID` INT NOT NULL DEFAULT 0,
  `PowerDisplayID_1` INT NOT NULL DEFAULT 0,
  `PowerDisplayID_2` INT NOT NULL DEFAULT 0,
  `PowerDisplayID_3` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=UTF8MB4;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `vehicle_dbc` WRITE;
/*!40000 ALTER TABLE `vehicle_dbc` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicle_dbc` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

