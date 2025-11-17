--
DELETE FROM `creature_template_model` WHERE (`CreatureID` = 25342);
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(25342, 0, 23250, 1, 1, 12340);

DELETE FROM `creature_template_model` WHERE (`CreatureID` = 25343);
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(25343, 0, 23246, 1, 1, 12340),
(25343, 1, 23247, 1, 1, 12340),
(25343, 2, 23248, 1, 1, 12340),
(25343, 3, 23249, 1, 1, 12340);
