-- DB update 2023_11_20_00 -> 2023_11_20_01
-- Prayer of Mending inspiration
UPDATE `spell_proc_event` SET `SpellFamilyMask1` = `SpellFamilyMask1`|32 WHERE entry = -14892;
