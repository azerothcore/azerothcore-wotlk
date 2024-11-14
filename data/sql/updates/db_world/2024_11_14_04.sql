-- DB update 2024_11_14_03 -> 2024_11_14_04
--
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_item_spell_reflectors';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(23132, 'spell_item_spell_reflectors'),
(23097, 'spell_item_spell_reflectors'),
(23131, 'spell_item_spell_reflectors');
