-- DB update 2025_12_26_11 -> 2025_12_27_00
DELETE FROM `creature_template_model` WHERE `CreatureID` = 29134;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(29134, 0, 6302, 1, 1, 51831),
(29134, 1, 1924, 1, 0, 51831),
(29134, 2, 2176, 1, 0, 51831),
(29134, 3, 304, 1, 0, 51831);
