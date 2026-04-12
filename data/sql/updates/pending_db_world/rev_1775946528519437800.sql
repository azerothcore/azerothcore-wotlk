-- Fix spell_proc: Add missing proc entry for spell 60485 and fix SpellTypeMask for spell 60519
DELETE FROM `spell_proc` WHERE `SpellId` IN (60485, 60519);
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(60485, 0, 0, 0, 0, 0, 81920, 3, 4, 0, 0, 0, 0, 0, 0, 0),
(60519, 0, 0, 0, 0, 0, 82944, 3, 2, 0, 0, 0, 0, 0, 50000, 0);
