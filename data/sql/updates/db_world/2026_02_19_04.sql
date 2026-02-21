-- DB update 2026_02_19_03 -> 2026_02_19_04
-- Soul Preserver (60510): add spell_proc entry to fix proc for non-Paladin healers
-- Auto-generated entry had SpellFamilyName=10 (Paladin) which blocked other classes
-- ProcFlags 0x4400: DONE_SPELL_MAGIC_DMG_CLASS_POS + DONE_SPELL_NONE_DMG_CLASS_POS (direct heals + HoTs)
-- SpellTypeMask 6: HEAL + NO_DMG_HEAL (HoT applications)
DELETE FROM `spell_proc` WHERE `SpellId` = 60510;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`)
VALUES (60510, 0, 0, 0, 0, 0, 0x4400, 6, 2, 0, 0, 0, 0, 0, 0, 0);

-- Spark of Life (60519): add DONE_SPELL_NONE_DMG_CLASS_POS (0x400) and NO_DMG_HEAL to SpellTypeMask
-- Allows HoT casts to trigger the proc
UPDATE `spell_proc` SET `ProcFlags` = 0x14400, `SpellTypeMask` = 7 WHERE `SpellId` = 60519;
