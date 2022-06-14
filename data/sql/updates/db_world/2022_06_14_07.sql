-- DB update 2022_06_14_06 -> 2022_06_14_07
--
DELETE FROM `spell_script_names` WHERE `spell_id`=29341;
INSERT INTO `spell_script_names` VALUES
(29341,'spell_warl_shadowburn');
