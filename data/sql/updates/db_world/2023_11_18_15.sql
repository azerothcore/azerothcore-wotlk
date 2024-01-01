-- DB update 2023_11_18_14 -> 2023_11_18_15
-- SH - Spell Bomb - proc only on cast
DELETE FROM `spell_proc_event` WHERE `entry`=40303;
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `procPhase`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(40303, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);
