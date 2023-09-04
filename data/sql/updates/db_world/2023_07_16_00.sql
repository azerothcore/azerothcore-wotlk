-- DB update 2023_07_15_04 -> 2023_07_16_00
--
DELETE FROM `spell_proc_event` WHERE `entry` IN (46662);
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `procPhase`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(46662,0,0,0,0,0,0,0,0,0,0,25000);
