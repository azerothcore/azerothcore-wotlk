-- DB update 2023_04_02_10 -> 2023_04_02_11
--
DELETE FROM `spell_proc_event` WHERE `entry`=43730;
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `procPhase`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(43730,0,0,0,0,0,0,0,2,0,0,8000);
