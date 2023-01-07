-- DB update 2023_01_07_06 -> 2023_01_07_07
--
DELETE FROM `spell_script_names` WHERE `spell_id`=37678 AND `ScriptName`='spell_item_elixir_of_shadows';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(37678, 'spell_item_elixir_of_shadows');
