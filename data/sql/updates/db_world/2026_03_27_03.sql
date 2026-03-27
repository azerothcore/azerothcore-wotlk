-- DB update 2026_03_27_02 -> 2026_03_27_03
--
DELETE FROM `creature_equip_template` WHERE (`CreatureID` = 28912);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES
(28912, 1, 38633, 0, 0, 42010);

UPDATE `creature` SET `spawntimesecs` = 60 WHERE (`id1` = 28912) AND (`guid` IN (130354));

UPDATE `creature_template` SET `CreatureImmunitiesId` = -93 WHERE (`entry` = 28912);
