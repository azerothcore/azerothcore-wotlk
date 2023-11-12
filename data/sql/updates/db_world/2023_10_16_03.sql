-- DB update 2023_10_16_02 -> 2023_10_16_03
--
DELETE FROM `spell_proc_event` WHERE `entry`=35399;
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `procPhase`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(35399, 0, 0, 0, 0, 0, 131072, 2048, 0, 0, 0, 0);
