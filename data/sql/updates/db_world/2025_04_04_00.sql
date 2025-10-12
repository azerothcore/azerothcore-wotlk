-- DB update 2025_04_03_00 -> 2025_04_04_00
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 46268;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (46268, 'spell_muru_blackhole');
