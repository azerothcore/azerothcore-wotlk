-- DB update 2023_10_12_00 -> 2023_10_12_01
-- Item - Chamber of Aspects 25 Nuker Trinket
DELETE FROM `spell_proc_event` WHERE `entry` = 75465;
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `procPhase`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(75465,0,0,0,0,0,0,0,0,0,0,45000);

-- Item - Chamber of Aspects 25 Heroic Nuker Trinket
UPDATE `spell_proc_event` SET `Cooldown` = 45000 WHERE `entry` = 75474;
