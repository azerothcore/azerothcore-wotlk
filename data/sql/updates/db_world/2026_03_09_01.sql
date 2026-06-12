-- DB update 2026_03_09_00 -> 2026_03_09_01
DELETE FROM `spell_proc` WHERE `SpellId` IN (57529, 57531);
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(57529, 0, 3, 0x61401035, 0x00001000, 0, 0, 0, 1, 0, 0x8, 0, 0, 0, 0, 0),
(57531, 0, 3, 0x61401035, 0x00001000, 0, 0, 0, 1, 0, 0x8, 0, 0, 0, 0, 0);
