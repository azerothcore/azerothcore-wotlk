-- Item - Chamber of Aspects 25 Nuker Trinket
DELETE FROM `spell_proc_event` WHERE `entry` = 75465;
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `procPhase`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(75465,0,0,0,0,0,0,0,0,0,0,50000);
