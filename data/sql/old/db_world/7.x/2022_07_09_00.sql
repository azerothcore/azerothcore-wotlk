-- DB update 2022_07_07_00 -> 2022_07_09_00
--
DELETE FROM `spell_script_names` WHERE `spell_id`=24324;
INSERT INTO `spell_script_names` VALUES
(24324,'spell_blood_siphon');
