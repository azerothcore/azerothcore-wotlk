-- DB update 2026_02_27_01 -> 2026_02_27_02
-- Fix "on cast" procs: add missing NONE DmgClass flags and correct SpellPhaseMask
-- These spells have tooltips like "chance on successful spellcast" but were missing
-- DONE_SPELL_NONE_DMG_CLASS_POS/NEG flags, preventing NONE-DmgClass spells from
-- proccing them. Some also had SpellPhaseMask=2 (HIT) instead of 1 (CAST).

-- [27521] Mana Restore - "2% chance on successful spellcast to restore mana"
-- Phase HIT->CAST, add NONE flags: 0x14000 -> 0x15400
UPDATE `spell_proc` SET `ProcFlags` = 0x15400, `SpellPhaseMask` = 1 WHERE `SpellId` = 27521;

-- [27774] The Furious Storm - "Chance on spell cast to increase your spell power"
-- Phase HIT->CAST, add NONE flags: 0x14000 -> 0x15400
UPDATE `spell_proc` SET `ProcFlags` = 0x15400, `SpellPhaseMask` = 1 WHERE `SpellId` = 27774;

-- [32837] Spell Focus Trigger - "Chance on successful spellcast to grant Spell Haste"
-- Phase HIT->CAST, add NONE flags: 0x14000 -> 0x15400
UPDATE `spell_proc` SET `ProcFlags` = 0x15400, `SpellPhaseMask` = 1 WHERE `SpellId` = 32837;

-- [32980] Arcane Might - "2% chance on successful spellcast to increase spell power"
-- No spell_proc entry existed. Add with NONE flags and CAST phase.
DELETE FROM `spell_proc` WHERE `SpellId` = 32980;
INSERT INTO `spell_proc` (`SpellId`, `ProcFlags`, `SpellPhaseMask`) VALUES (32980, 0x15400, 1);

-- [32981] Verdant Flame - "Chance on successful spellcast to restore Mana"
-- No spell_proc entry existed. Add with NONE flags and CAST phase.
DELETE FROM `spell_proc` WHERE `SpellId` = 32981;
INSERT INTO `spell_proc` (`SpellId`, `ProcFlags`, `SpellPhaseMask`) VALUES (32981, 0x15400, 1);

-- [34584] Love Struck - "Chance on spell cast to increase your Spirit"
-- Phase HIT->CAST, add NONE flags: 0x14000 -> 0x15400
UPDATE `spell_proc` SET `ProcFlags` = 0x15400, `SpellPhaseMask` = 1 WHERE `SpellId` = 34584;

-- [38334] Proc Mana Regen - "Your spell casts have a chance to allow mana regen"
-- Phase HIT->CAST, add NONE flags: 0x14000 -> 0x15400
UPDATE `spell_proc` SET `ProcFlags` = 0x15400, `SpellPhaseMask` = 1 WHERE `SpellId` = 38334;

-- [55381] Mana Restore - "2% chance on successful spellcast to restore mana"
-- Phase HIT->CAST, add NONE flags: 0x14000 -> 0x15400
UPDATE `spell_proc` SET `ProcFlags` = 0x15400, `SpellPhaseMask` = 1 WHERE `SpellId` = 55381;

-- [58442] Airy Pale Ale - "Chance on successful spellcast to restore mana"
-- Phase HIT->CAST, add NONE flags: 0x14000 -> 0x15400
UPDATE `spell_proc` SET `ProcFlags` = 0x15400, `SpellPhaseMask` = 1 WHERE `SpellId` = 58442;

-- [62114] Flow of Knowledge - "Your spell casts have a chance to increase spell power"
-- Phase HIT->CAST, add NONE flags: 0x54000 -> 0x55400
UPDATE `spell_proc` SET `ProcFlags` = 0x55400, `SpellPhaseMask` = 1 WHERE `SpellId` = 62114;

-- [71585] Item - Icecrown 25 Emblem Healer Trinket - "Your spell casts have a chance to grant mana per 5 sec"
-- Phase already CAST, just add NONE flags: 0x14000 -> 0x15400
UPDATE `spell_proc` SET `ProcFlags` = 0x15400 WHERE `SpellId` = 71585;
