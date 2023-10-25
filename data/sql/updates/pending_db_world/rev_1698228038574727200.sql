-- Skullflame Shield / Demon Forged Breastplate proc on critical/normal/partial block
DELETE FROM `spell_proc_event` WHERE `entry`=16611; -- Demon Forged Breastplate
DELETE FROM `spell_proc_event` WHERE `entry`=18815; -- Drain Life
DELETE FROM `spell_proc_event` WHERE `entry`=18816; -- Flamestrike
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `procPhase`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(16611, 0, 0, 0, 0, 0, 0, 67, 0, 0, 0, 0),
(18815, 0, 0, 0, 0, 0, 0, 67, 0, 0, 0, 0),
(18816, 0, 0, 0, 0, 0, 0, 67, 0, 0, 0, 0);
