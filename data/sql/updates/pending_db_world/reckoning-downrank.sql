DELETE FROM `spell_proc_event` WHERE `entry` IN (20177, 20179, 20180, 20181);
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `procPhase`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(20177, 0, 0, 0, 0, 0, 0, 262211, 0, 0, 0, 0), -- I
(20179, 0, 0, 0, 0, 0, 0, 262211, 0, 0, 0, 0), -- II
(20181, 0, 0, 0, 0, 0, 0, 262211, 0, 0, 0, 0), -- III
(20180, 0, 0, 0, 0, 0, 0, 262211, 0, 0, 0, 0); -- IV
