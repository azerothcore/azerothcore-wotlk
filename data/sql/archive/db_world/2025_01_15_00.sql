-- DB update 2025_01_14_05 -> 2025_01_15_00
--
DELETE FROM `spell_script_names` WHERE `spell_id`=43983 AND `ScriptName`='spell_gen_allow_proc_from_spells_with_cost';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES(43983, 'spell_gen_allow_proc_from_spells_with_cost');
