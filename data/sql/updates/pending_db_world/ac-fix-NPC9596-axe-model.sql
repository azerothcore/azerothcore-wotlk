-- Added missing ranged weapon for SpellID 6466
UPDATE `creature_equip_template` SET `ItemID3` = 5856, `VerifiedBuild` = 0 WHERE (`CreatureID` = 9596);
