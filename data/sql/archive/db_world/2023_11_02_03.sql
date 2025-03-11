-- DB update 2023_11_02_02 -> 2023_11_02_03
-- Skullflame Shield / Demon Forged Breastplate proc on critical/normal/partial block
-- Demon Forged Breastplate, Drain Life, Flamestrike
DELETE FROM `spell_proc_event` WHERE `entry` IN (16611,18815,18816);
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `procPhase`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(16611, 0, 0, 0, 0, 0, 0, 67, 0, 0, 0, 0),
(18815, 0, 0, 0, 0, 0, 0, 67, 0, 0, 0, 0),
(18816, 0, 0, 0, 0, 0, 0, 67, 0, 0, 0, 0);
