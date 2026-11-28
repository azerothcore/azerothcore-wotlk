--
DELETE FROM `spell_proc` WHERE `SpellId` IN (54309, 59352);
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(54309, 0, 0, 0, 0, 0, 0x8800, 0x2, 0x2, 0, 0, 0, 0, 0, 0, 0),
(59352, 0, 0, 0, 0, 0, 0x8800, 0x2, 0x2, 0, 0, 0, 0, 0, 0, 0);
