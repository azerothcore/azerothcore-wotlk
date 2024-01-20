-- DB update 2023_05_13_00 -> 2023_05_13_01
--
DELETE FROM `creature_equip_template` WHERE `CreatureID` = 16809 AND `ID` IN (1, 2);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES 
(16809, 1, 29484, 0, 0, 48999),
(16809, 2, 29479, 0, 0, 48999);
