INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631557649018772603');

DELETE FROM `spell_script_names` WHERE `spell_id` = 23134;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (23134, 'spell_item_poweful_anti_venom');