INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636756491721328900');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_item_party_time';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(8067, 'spell_item_party_time');
