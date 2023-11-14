--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (20185,20186);
INSERT INTO `spell_script_names` VALUES
(20185, 'spell_pal_judgement_of_light_heal'),
(20186, 'spell_pal_judgement_of_wisdom_mana');
