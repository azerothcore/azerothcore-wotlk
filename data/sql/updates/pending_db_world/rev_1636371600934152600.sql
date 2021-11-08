INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636371600934152600');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_mage_polymorph_visual';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(32826,'spell_mage_polymorph_cast_visual');
