-- Missile Barrage: consume on FINISH instead of CAST; its mods (DURATION,
-- ACTIVATION_TIME, COST) are applied inside handle_immediate, after CAST fires.
UPDATE `spell_proc` SET `SpellPhaseMask` = 4 WHERE `SpellId` = 44401;
