INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1553390628412350005');

DELETE FROM `spell_script_names` WHERE spell_id=63414;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (63414, 'spell_mimiron_spinning_up');
