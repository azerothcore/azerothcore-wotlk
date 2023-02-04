-- DB update 2022_11_21_11 -> 2022_11_21_12
--
DELETE FROM `spell_script_names` WHERE `spell_id`=24926;
INSERT INTO `spell_script_names` VALUES
(24926,'spell_hallows_end_candy_pirate_costume');
