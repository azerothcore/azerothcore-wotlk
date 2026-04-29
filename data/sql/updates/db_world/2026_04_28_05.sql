-- DB update 2026_04_28_04 -> 2026_04_28_05
-- Ribbon of Sacrifice (28590) - Blessing of Life proc on direct heals
DELETE FROM `spell_proc` WHERE `SpellId` = 38332;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES (38332, 0, 0, 0, 0, 0, 0x4000, 2, 2, 0, 0, 0, 0, 100, 0, 0);
