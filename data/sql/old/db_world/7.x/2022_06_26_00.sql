-- DB update 2022_06_22_03 -> 2022_06_26_00
--
DELETE FROM `spell_script_names` WHERE `spell_id`=24315;
INSERT INTO `spell_script_names` VALUES
(24315,'spell_threatening_gaze_charge');
