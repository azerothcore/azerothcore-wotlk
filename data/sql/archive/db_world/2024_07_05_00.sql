-- DB update 2024_07_04_06 -> 2024_07_05_00
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 38929;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(38929, 'spell_item_fel_mana_potion');
