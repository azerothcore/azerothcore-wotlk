-- DB update 2026_07_22_12 -> 2026_07_22_13
DELETE FROM `creature_template_model` WHERE `CreatureID` IN (34129, 34153);
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(34129, 0, 169, 1, 0, 51831),
(34129, 1, 23258, 1, 1, 51831),
(34153, 0, 169, 1, 0, 51831),
(34153, 1, 23258, 1, 1, 51831);
