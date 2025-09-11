--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (29007, 29008);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(29007, 'spell_gen_food_heart_emote'),
(29008, 'spell_gen_food_heart_emote');
