--
-- Hamstring 0x0002, Rend 0x0020, Sunder Armor 0x4000
UPDATE `spell_proc_event` SET `SpellFamilyMask0`=`SpellFamilyMask0` | (0x0002 | 0x0020 | 0x4000) WHERE `entry`=-12281;
