-- DB update 2024_11_04_08 -> 2024_11_05_00
--
DELETE FROM `spell_script_names` WHERE `spell_id`=23595 AND `ScriptName`='spell_item_luffa';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (23595, 'spell_item_luffa');
