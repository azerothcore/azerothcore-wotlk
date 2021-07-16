INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626472277718613700');

DELETE FROM `spell_script_names` WHERE `spell_id` = 46642 AND `ScriptName` = 'spell_gen_5000_gold';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(46642, 'spell_gen_5000_gold');
