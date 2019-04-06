INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1554524766481187700');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_red_sky_effect';
INSERT INTO `spell_script_names` VALUES
(32111, 'spell_red_sky_effect');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_finger_of_death';
INSERT INTO `spell_script_names` VALUES
(31984, 'spell_finger_of_death');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_hand_of_death';
INSERT INTO `spell_script_names` VALUES
(35354, 'spell_hand_of_death');
