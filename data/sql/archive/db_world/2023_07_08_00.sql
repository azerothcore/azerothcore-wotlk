-- DB update 2023_07_02_00 -> 2023_07_08_00
-- Shriveling Gaze
DELETE FROM `spell_script_names` WHERE `spell_id` = 37589;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(37589,'spell_gen_shriveling_gaze');
