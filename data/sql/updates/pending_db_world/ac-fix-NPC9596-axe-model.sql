-- Added missing ranged weapon for SpellID 6466
DELETE FROM `creature_equip_template` WHERE (`CreatureID` = 9596);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES
(9596, 1, 7612, 0, 5856, 18019);
