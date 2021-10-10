INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633798793231677400');

DELETE FROM `event_scripts` WHERE `id` = 4975 AND `command` = 10;

DELETE FROM `spell_script_names` WHERE `spell_id` = 16796 AND `ScriptName` = 'spell_q5056_summon_shy_rotam';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(16796, 'spell_q5056_summon_shy_rotam');
