-- DB update 2023_10_25_02 -> 2023_10_29_00
-- Judgement Group Heal (Ranged Ability -> Physical Ability)
DELETE FROM `spell_proc_event` WHERE `entry`=37195;
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `procPhase`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(37195, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0);
