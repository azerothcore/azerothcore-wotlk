-- DB update 2026_02_25_02 -> 2026_02_25_03
-- HitMask 0x477 = PROC_HIT_NORMAL | PROC_HIT_CRITICAL | PROC_HIT_MISS | PROC_HIT_DODGE | PROC_HIT_PARRY | PROC_HIT_BLOCK | PROC_HIT_ABSORB
DELETE FROM `spell_proc` WHERE `SpellId` = -65661;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(-65661, 0, 15, 4194321, 537001988, 0, 0x10, 0, 2, 0x477, 0, 0, 0, 100, 0, 0);
