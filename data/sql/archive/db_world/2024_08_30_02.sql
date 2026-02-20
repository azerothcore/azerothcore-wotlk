-- DB update 2024_08_30_01 -> 2024_08_30_02
--
DELETE FROM `spell_script_names` WHERE `spell_id`=39497;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES(39497, 'spell_kaelthas_remove_enchanted_weapons');
