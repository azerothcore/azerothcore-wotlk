INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636293158309628100');

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_deathwhisper_dark_reckoning';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(69483,'spell_deathwhisper_dark_reckoning');
