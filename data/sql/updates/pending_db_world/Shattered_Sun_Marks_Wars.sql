
--Shattered Sun Marksmans

DELETE FROM `creature_template_model` WHERE (`CreatureID` = 24938) AND (`Idx` IN (0, 1, 2, 3));
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(24938, 0, 22752, 1, 1, 0),
(24938, 1, 22757, 1, 1, 0),
(24938, 2, 22753, 1, 1, 0),
(24938, 3, 22763, 1, 1, 0);



--Shattered Sun Warriors

DELETE FROM `creature_template_model` WHERE (`CreatureID` = 25115) AND (`Idx` IN (0, 1, 2, 3));
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(25115, 0, 22752, 1, 1, 0),
(25115, 1, 22757, 1, 1, 0),
(25115, 2, 22753, 1, 1, 0),
(25115, 3, 22763, 1, 1, 0);
