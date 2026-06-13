-- DB update 2026_03_11_00 -> 2026_03_11_01
-- Restrict "on spellcast" procs to damage/heal only (SpellTypeMask=3)
-- Prevents proccing from utility spells like Open Lock (doors with keys)
UPDATE `spell_proc` SET `SpellTypeMask` = 3 WHERE `SpellId` IN (27521, 27774, 32837, 32980, 32981, 34584, 38334, 55381, 58442, 62114, 71585);
