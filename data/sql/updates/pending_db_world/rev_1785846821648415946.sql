-- Savage Combat (-51682) never procced off Wound Poison: SpellTypeMask 4 is
-- PROC_SPELL_TYPE_NO_DMG_HEAL, and Wound Poison is the one debuff poison that also deals
-- direct damage. Widened to 5 (DAMAGE | NO_DMG_HEAL), which also covers Instant Poison.
UPDATE `spell_proc` SET `SpellTypeMask` = 5 WHERE `SpellId` = -51682;
