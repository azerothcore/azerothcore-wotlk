-- DB update 2023_01_07_05 -> 2023_01_07_06
--
DELETE FROM `spell_script_names` WHERE `spell_id`=32065;
INSERT INTO `spell_script_names` VALUES
(32065,'spell_fungal_decay');
