INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1561127338947558444');

DELETE FROM `spell_script_names` WHERE `spell_id` = 53768;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (53768,'spell_gen_haunted');
