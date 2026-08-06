-- Savage Combat only procced off poisons that deal no damage (SpellTypeMask 4), which left out
-- Wound Poison and Instant Poison. Add PROC_SPELL_TYPE_DAMAGE.
UPDATE `spell_proc` SET `SpellTypeMask` = `SpellTypeMask`|1 WHERE `SpellId` = -51682;
