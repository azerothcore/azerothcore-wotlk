-- Fix Spark of Life (spell 60519) proc on craft and equip
UPDATE `spell_proc` SET `SpellTypeMask` = 3 WHERE `SpellId` = 60519;
