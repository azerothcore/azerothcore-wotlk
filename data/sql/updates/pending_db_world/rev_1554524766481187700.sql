INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1554524766481187700');

DELETE FROM `spell_script_names` WHERE `entry` IN ('spell_red_sky_effect', 'spell_finger_of_death', 'spell_hand_of_death');

INSERT INTO `spell_script_names` VALUES
(32111, 'spell_red_sky_effect'),
(31984, 'spell_finger_of_death'),
(35354, 'spell_hand_of_death');
