INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627403306832649400');

DELETE FROM `spell_script_names` WHERE `spell_id`=-16257;
INSERT INTO `spell_script_names` VALUES
(-16257,'spell_sha_flurry_proc');
