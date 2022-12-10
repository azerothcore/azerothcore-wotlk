-- DB update 2022_08_27_00 -> 2022_08_27_01
--
DELETE FROM `spell_script_names` WHERE `spell_id`=25153;
INSERT INTO `spell_script_names` VALUES
(25153,'spell_aggro_drones');
