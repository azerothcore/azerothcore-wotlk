-- DB update 2026_03_07_01 -> 2026_03_07_02
-- Rime (49188/56822/59057) should only proc from Obliterate (SpellFamilyMask1 = 0x20000)
DELETE FROM `spell_proc` WHERE `SpellId` = -49188;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`)
VALUES (-49188, 0, 15, 0x00000000, 0x00020000, 0x00000000, 0, 0, 0x2, 0, 0, 0, 0, 0, 0, 0);
