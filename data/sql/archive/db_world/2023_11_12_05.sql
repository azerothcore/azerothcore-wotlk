-- DB update 2023_11_12_04 -> 2023_11_12_05
-- Carinda's Scroll of Retribution
DELETE FROM `spell_script_names` WHERE `spell_id`=30077 AND `ScriptName` = 'spell_item_scroll_of_retribution';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (30077, 'spell_item_scroll_of_retribution');
