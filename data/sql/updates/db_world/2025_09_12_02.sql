-- DB update 2025_09_12_01 -> 2025_09_12_02
--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (29007, 29008) AND `ScriptName`='spell_gen_food_heart_emote';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(29007, 'spell_gen_food_heart_emote'),
(29008, 'spell_gen_food_heart_emote');
