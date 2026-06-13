-- DB update 2024_10_11_02 -> 2024_10_11_03
DELETE FROM `spell_script_names` WHERE `spell_id` = 40354;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (40354, 'spell_najentus_remove_spines');
