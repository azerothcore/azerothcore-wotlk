-- DB update 2026_02_22_05 -> 2026_02_22_06
-- Lock and Load: allow periodic tick procs (Black Arrow, Explosive Trap)
-- SpellPhaseMask 6 = PROC_SPELL_PHASE_HIT | PROC_SPELL_PHASE_FINISH
UPDATE `spell_proc` SET `SpellPhaseMask` = 6 WHERE `SpellId` = -56342;
