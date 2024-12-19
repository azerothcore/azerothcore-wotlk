-- Sword Specialization - Sunder Armor/Hamstring/Rend (Mask1 was 1:1 with DBC)
UPDATE `spell_proc_event` SET `SpellFamilyMask0`=2858435686, `SpellFamilyMask1`=0 WHERE `entry`= -12281;

-- Sudden Death - Hamstring/Rend
DELETE FROM `spell_proc_event` WHERE `entry`=-29723;
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `procPhase`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(-29723, 0, 0, 34, 0, 0, 0, 0, 0, 0, 0, 0);
