-- DB update 2026_05_16_02 -> 2026_05_17_00
DELETE FROM `spell_proc` WHERE `SpellId` = 20178;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(20178, 0, 0, 0, 0, 0, 0x4, 0, 0, 0x2477, 0, 0, 0, 100, 0, 4);
