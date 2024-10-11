-- DB update 2024_10_11_03 -> 2024_10_11_04
DELETE FROM `creature_template_model` WHERE `CreatureID` = 22871;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(22871, 0, 21254, 1, 0, 51831),
(22871, 1, 21262, 1, 1, 51831);
