INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623660631649831200');

DELETE FROM `spell_script_names` WHERE `spell_id` = 34428;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (34428, 'spell_warr_victory_rush');
