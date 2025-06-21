--
-- Sword Specialization: Hamstring 0x0002, Rend 0x0020, Sunder Armor 0x4000
UPDATE `spell_proc_event` SET `SpellFamilyMask0`=`SpellFamilyMask0` | (0x0002 | 0x0020 | 0x4000) WHERE `entry`=-12281;

-- Sudden Death: copy FamilyMask from Sword Specialization
DELETE FROM `spell_proc_event` WHERE `entry`=-29723;
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`) VALUES
(-29723, 0, 4, 2858435686, 4194565, 0);
