-- DB update 2023_07_15_01 -> 2023_07_15_02
--
DELETE FROM `spell_proc_event` WHERE `entry` IN (38319);
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `procPhase`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(38319,0,0,0,0,0,0,0,0,0,0,50000);
