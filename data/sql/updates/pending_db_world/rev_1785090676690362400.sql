-- Issue #26779: Warrior "Sudden Death" proc buff (52437) was consuming itself on Execute's
-- PROC_SPELL_PHASE_FINISH (spell cast completed, regardless of outcome) instead of
-- PROC_SPELL_PHASE_HIT (landed only) - so a missed/dodged/parried Execute still burned the
-- buff, even though nothing consumed the "free execute" effect it grants.
UPDATE `spell_proc` SET `SpellPhaseMask` = 2 WHERE `SpellId` = 52437;
