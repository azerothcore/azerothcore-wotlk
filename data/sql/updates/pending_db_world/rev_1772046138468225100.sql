--
DELETE FROM `spell_proc` WHERE `SpellId` = 43730;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(43730, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 8000, 0);
