INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1650555787208782000');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_igb_battle_experience_check';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(71201, 'spell_igb_battle_experience_check');
