INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1554524766481187700');

DELETE FROM `spell_script_names` WHERE `spell_id` IN (32111, 31984, 35354);

INSERT INTO `spell_script_names` VALUES
(32111, 'spell_red_sky_effect'),
(31984, 'spell_finger_of_death'),
(35354, 'spell_hand_of_death');
