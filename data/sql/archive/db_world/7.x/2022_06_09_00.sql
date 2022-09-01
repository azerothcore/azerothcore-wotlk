-- DB update 2022_06_08_02 -> 2022_06_09_00
--
DELETE FROM `spell_script_names` WHERE `spell_id`=24326;
INSERT INTO `spell_script_names` VALUES
(24326,'spell_gahzranka_slam');
