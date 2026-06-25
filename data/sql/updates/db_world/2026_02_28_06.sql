-- DB update 2026_02_28_05 -> 2026_02_28_06
DELETE FROM `spell_script_names` WHERE `spell_id` = 38132 AND `ScriptName` = 'spell_lady_vashj_tainted_core_paralyze';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(38132, 'spell_lady_vashj_tainted_core_paralyze');
