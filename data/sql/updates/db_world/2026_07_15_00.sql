-- DB update 2026_07_14_03 -> 2026_07_15_00
-- Missile Barrage: consume on FINISH instead of CAST; its mods (DURATION,
-- ACTIVATION_TIME, COST) are applied inside handle_immediate, after CAST fires.
UPDATE `spell_proc` SET `SpellPhaseMask` = 4 WHERE `SpellId` = 44401;
