-- Savage Combat (51682, all ranks) never procced off Wound Poison, issue #26885. Its
-- SpellTypeMask only accepted PROC_SPELL_TYPE_NO_DMG_HEAL, and Wound Poison is the one
-- debuff-poison that also deals direct damage, so the proc system classified it as
-- PROC_SPELL_TYPE_DAMAGE instead.
UPDATE `spell_proc` SET `SpellTypeMask` = `SpellTypeMask`|1 WHERE `SpellId` = -51682;
