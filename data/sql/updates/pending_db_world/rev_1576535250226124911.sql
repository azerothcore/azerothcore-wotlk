INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1576535250226124911');

DELETE FROM `spell_script_names` WHERE `spell_id` = 70937;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`)
VALUES
(70937, 'spell_mage_glyph_of_eternal_water');
