INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635964941654899600');
DELETE FROM `spell_script_names` WHERE `spell_id`=20478 AND `ScriptName`='spell_geddon_armageddon';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(20478, 'spell_geddon_armageddon');
