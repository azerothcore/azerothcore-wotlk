INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632872192462777000');

DELETE FROM `spell_script_names` WHERE  `spell_id` = -1120 AND `ScriptName` = 'spell_warl_drain_soul';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-1120, 'spell_warl_drain_soul');
