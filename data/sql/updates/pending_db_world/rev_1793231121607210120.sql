--
-- Glyph of Shadowfiend: proc only when the Shadowfiend is killed (PROC_FLAG_KILLED) instead of on every hit it takes
DELETE FROM `spell_proc` WHERE `SpellId` = 57989;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(57989, 0, 0, 0, 0, 0, 0x1, 1, 0, 0, 0, 0, 0, 0, 0, 0);
