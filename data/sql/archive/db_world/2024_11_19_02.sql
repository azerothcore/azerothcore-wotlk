-- DB update 2024_11_19_01 -> 2024_11_19_02
-- Multiphase Goggles
DELETE FROM `spell_script_names` WHERE `spell_id`=46273 AND `ScriptName`='spell_item_multiphase_goggles';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (46273, 'spell_item_multiphase_goggles');
