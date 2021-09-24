INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632482613720296800');

DELETE FROM `spell_script_names` WHERE `spell_id`=43714;
INSERT INTO `spell_script_names` VALUES
(43714,'spell_brewfest_relay_race_force_cast');
