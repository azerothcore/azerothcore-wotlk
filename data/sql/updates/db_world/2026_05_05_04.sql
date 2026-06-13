-- DB update 2026_05_05_03 -> 2026_05_05_04
-- Talisman of Troll Divinity (37734) - Touched by a Troll proc on direct heals
DELETE FROM `spell_proc` WHERE `SpellId` = 60517;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(60517, 0, 0, 0, 0, 0, 0x4000, 2, 2, 0, 0, 0, 0, 100, 0, 0);
