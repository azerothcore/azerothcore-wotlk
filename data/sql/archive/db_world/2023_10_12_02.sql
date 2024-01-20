-- DB update 2023_10_12_01 -> 2023_10_12_02
-- 37565 - Flexibility | Item - Priest T4 Holy/Discipline 4P Bonus
DELETE FROM `spell_script_names` WHERE `spell_id`=37565;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (37565, 'spell_pri_t4_4p_bonus');

DELETE FROM `spell_proc_event` WHERE `entry`=37565;
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `procPhase`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(37565, 0, 6, 4096, 0, 0, 16384, 0, 1, 0, 0, 0);
