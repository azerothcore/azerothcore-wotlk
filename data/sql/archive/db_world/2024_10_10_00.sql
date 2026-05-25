-- DB update 2024_10_09_00 -> 2024_10_10_00
DELETE FROM `creature_template_model` WHERE `CreatureID` = 23369;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(23369, 0, 1126, 1, 0, 51831),
(23369, 1, 16946, 1, 1, 51831);
