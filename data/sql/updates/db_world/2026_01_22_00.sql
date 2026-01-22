-- DB update 2026_01_21_02 -> 2026_01_22_00
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 28375;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(28375, 'spell_gluth_decimate_damage');
