-- DB update 2026_04_28_05 -> 2026_04_28_06
-- Fix Spark of Life (spell 60519) proc on craft and equip
UPDATE `spell_proc` SET `SpellTypeMask` = 3 WHERE `SpellId` = 60519;
