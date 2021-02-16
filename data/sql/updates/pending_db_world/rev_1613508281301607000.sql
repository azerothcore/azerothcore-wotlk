INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1613508281301607000');
DELETE FROM `spell_script_names` WHERE `spell_id` = -20335;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-20335, 'spell_pal_heart_of_the_crusader');
