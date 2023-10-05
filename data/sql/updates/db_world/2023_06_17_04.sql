-- DB update 2023_06_17_03 -> 2023_06_17_04
--
DELETE FROM `spell_proc_event` WHERE `entry` IN (27997, 33511, 33522, 33510, 24256);
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `procPhase`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(27997,0,0,0,0,0,0,0,0,0,0,50000),
(33511,0,0,0,0,0,0,0,0,0,0,17000),
(33522,0,0,0,0,0,0,0,0,0,0,25000),
(33510,0,0,0,0,0,0,0,0,0,0,25000),
(24256,0,0,0,0,0,0,0,0,0,0,240000);
