-- DB update 2026_06_28_01 -> 2026_06_30_00
-- Static Shock: restrict proc to melee-only flags (no longer procs on magic spells)
DELETE FROM `spell_proc` WHERE `SpellId` = -51525;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(-51525, 0, 0, 0, 0, 0, 12582932, 1, 2, 0, 0, 0, 0, 0, 0, 0);
