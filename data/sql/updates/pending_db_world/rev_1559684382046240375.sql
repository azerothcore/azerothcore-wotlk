INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1559684382046240375');

DELETE FROM `spell_script_names` WHERE `spell_id` IN (51186,51188,51189);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`)
VALUES
(51186,'spell_item_summon_or_dismiss'),
(51188,'spell_item_summon_or_dismiss'),
(51189,'spell_item_summon_or_dismiss');
