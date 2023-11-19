-- DB update 2023_11_19_01 -> 2023_11_19_02
-- Static Shock
DELETE FROM `spell_proc_event` WHERE `entry`=-51525;
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `procPhase`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(-51525, 0, 0, 0, 0, 0, 12582912, 0, 0, 0, 0, 0);
