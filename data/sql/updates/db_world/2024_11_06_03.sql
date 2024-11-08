-- DB update 2024_11_06_02 -> 2024_11_06_03
-- Obsidian Armor
DELETE FROM `spell_proc_event` WHERE `entry`=27539;
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `procPhase`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(27539, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 10000);
