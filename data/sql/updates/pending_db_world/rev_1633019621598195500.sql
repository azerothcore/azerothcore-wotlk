INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633019621598195500');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_hun_lock_and_load' AND `spell_id` = -56342;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-56342, 'spell_hun_lock_and_load');
