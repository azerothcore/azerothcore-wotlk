-- DB update 2022_10_01_02 -> 2022_10_01_03
--
DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15339) AND (`School` IN (2, 3, 4, 5));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15339, 2, 1000, 0),
(15339, 3, 1000, 0),
(15339, 4, 1000, 0),
(15339, 5, 1000, 0);
