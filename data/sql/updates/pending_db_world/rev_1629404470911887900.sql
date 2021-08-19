INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629404470911887900');

DELETE FROM `spell_script_names` WHERE `spell_id`=-42243;
INSERT INTO `spell_script_names` VALUES
(-42243,'spell_hun_volley_trigger');
