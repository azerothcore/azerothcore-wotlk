-- DB update 2026_02_25_04 -> 2026_02_25_05
-- Threat of Thassarian: OH attack should fire even when MH misses/dodges/parries
-- SpellTypeMask 0 = don't filter by spell type (miss/dodge/parry have no damage, so
--   PROC_SPELL_TYPE_DAMAGE won't match - need to allow PROC_SPELL_TYPE_NO_DMG_HEAL too)
-- HitMask 0x477 = PROC_HIT_NORMAL | PROC_HIT_CRITICAL | PROC_HIT_MISS | PROC_HIT_DODGE | PROC_HIT_PARRY | PROC_HIT_BLOCK | PROC_HIT_ABSORB
DELETE FROM `spell_proc` WHERE `SpellId` = -65661;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(-65661, 0, 15, 4194321, 537001988, 0, 0x10, 0, 2, 0x477, 0, 0, 0, 100, 0, 0);
