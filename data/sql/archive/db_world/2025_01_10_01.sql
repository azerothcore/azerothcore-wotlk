-- DB update 2025_01_10_00 -> 2025_01_10_01
--
DELETE FROM `spell_script_names` WHERE `spell_id`=42577 AND `ScriptName`='spell_zuljin_zap';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES(42577, 'spell_zuljin_zap');
-- 43983 Energy Storm, add CD to proc
DELETE FROM `spell_proc_event` WHERE `entry` = 43983;
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `procPhase`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(43983, 0, 0, 0, 0, 0, 0x4000|0x10000, 1|2, 1, 0.0, 100.0, 600);
