-- DB update 2024_07_30_00 -> 2024_07_30_01
--
DELETE FROM `spell_proc_event` WHERE `entry` = 40484;
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `procPhase`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(40484, 0, 0, 0, 0, 0, 0, 67, 0, 0, 0, 0);
