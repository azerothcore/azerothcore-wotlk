INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634891525914970200');

DELETE `spell_script_names` WHERE `spell_id` IN (22563, 22564) AND `ScriptName` = 'spell_item_recall';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(22563, 'spell_item_recall'),
(22564, 'spell_item_recall');
