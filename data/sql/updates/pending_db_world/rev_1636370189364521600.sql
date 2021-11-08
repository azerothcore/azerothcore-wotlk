INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636370189364521600');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_item_poweful_anti_venom';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(23786,'spell_item_powerful_anti_venom');
