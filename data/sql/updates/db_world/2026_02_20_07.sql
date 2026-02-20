-- DB update 2026_02_20_06 -> 2026_02_20_07
-- Inner Focus (14751) - Add spell_proc entry with PROC_ATTR_REQ_SPELLMOD
-- Without this, the proc system consumes the charge on the spell's own cast
-- because Inner Focus's SpellFamilyFlags overlap with its EffectSpellClassMask.
-- PROC_ATTR_REQ_SPELLMOD (0x8) ensures charges are only consumed when the
-- modifier is actually applied to the triggering spell.
DELETE FROM `spell_proc` WHERE `SpellId` = 14751;
INSERT INTO `spell_proc` (`SpellId`,`SchoolMask`,`SpellFamilyName`,`SpellFamilyMask0`,`SpellFamilyMask1`,`SpellFamilyMask2`,`ProcFlags`,`SpellTypeMask`,`SpellPhaseMask`,`HitMask`,`AttributesMask`,`DisableEffectsMask`,`ProcsPerMinute`,`Chance`,`Cooldown`,`Charges`) VALUES
(14751, 0, 6, 3755474943, 14521847, 8256, 0, 7, 2, 0, 8, 0, 0, 0, 0, 0);
