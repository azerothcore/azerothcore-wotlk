-- DB update 2026_01_23_03 -> 2026_01_24_00
--
DELETE FROM `spell_proc_event` WHERE `entry` = -49182;
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `procPhase`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(-49182, 0, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0);
